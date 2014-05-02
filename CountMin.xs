#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <../libcmsketch/cm.h>

#include "const-c.inc"

MODULE = CountMin		PACKAGE = CountMin		

INCLUDE: const-xs.inc


cmsketch_t *
sketch_new(w,d)
    int w
    int d


SV *
sketch_add(cms, b, count)
        cmsketch_t *cms
        SV * b
        uint32_t count
    CODE:
        STRLEN  blen = 0;
        char *bptr = SvPVbyte(b, blen);
        sketch_add(cms, bptr, blen, count);
        XSRETURN_UNDEF;
    OUTPUT:
        RETVAL


int
sketch_count(cms, b)
        cmsketch_t *cms
        SV * b
    CODE:
        STRLEN  blen = 0;
        char *bptr = SvPVbyte(b, blen);
        RETVAL = sketch_count(cms, bptr, blen);
    OUTPUT:
        RETVAL


SV *
sketch_merge(cms1, cms2)
	cmsketch_t *cms1
        cmsketch_t *cms2
    CODE:
        sketch_merge(cms1, cms2);
        XSRETURN_UNDEF;
    OUTPUT:
        RETVAL


SV *
sketch_compress(cms)
	cmsketch_t *cms
    CODE:
        sketch_compress(cms);
        XSRETURN_UNDEF;
    OUTPUT:
        RETVAL


cmsketch_t *
sketch_clone(cms)
	cmsketch_t *cms
    CODE:
        RETVAL = sketch_clone(cms);
    OUTPUT:
        RETVAL

AV *
sketch_values(cms,b)
        cmsketch_t *cms
        SV * b
    CODE:
        STRLEN  blen = 0;
        char *bptr = SvPVbyte(b, blen);
        uint32_t *vals = sketch_values(cms, bptr, blen);
        int i;
        AV* ret = newAV();
        sv_2mortal((SV*)ret);
        for(i=0;i<cms->d;i++) {
            av_push(ret, newSViv(vals[i]));
        }
        free(vals);
        RETVAL = ret;
    OUTPUT:
        RETVAL

MODULE = CountMin		PACKAGE = cmsketch_tPtr PREFIX=cmsptr_

SV *
cmsptr_DESTROY(cms)
    cmsketch_t *cms
    CODE:
        sketch_free(cms);
        XSRETURN_UNDEF;
    OUTPUT:
        RETVAL
