#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <../libcmsketch/cm.h>
#include <../libcmsketch/bf.h>

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


bfilter_t *
bfilter_new(w,h)
        int w
        int h



SV *
bfilter_add(bf,b)
    bfilter_t * bf
    SV * b
    CODE:
        STRLEN  blen = 0;
        char *bptr = SvPVbyte(b, blen);
        bfilter_add(bf, bptr, blen);
        XSRETURN_UNDEF;
    OUTPUT:
        RETVAL

bfilter_t *
bfilter_clone(bf)
        bfilter_t *bf
    CODE:
        RETVAL = bfilter_clone(bf);
    OUTPUT:
        RETVAL

SV *
bfilter_compress(bf)
	bfilter_t *bf
    CODE:
        bfilter_compress(bf);
        XSRETURN_UNDEF;
    OUTPUT:
        RETVAL

int
bfilter_exists(bf, b)
        bfilter_t *bf
        SV * b
    CODE:
        STRLEN  blen = 0;
        char *bptr = SvPVbyte(b, blen);
        RETVAL = bfilter_exists(bf, bptr, blen);
    OUTPUT:
        RETVAL


SV *
bfilter_merge(bf1, bf2)
	bfilter_t *bf1
        bfilter_t *bf2
    CODE:
        bfilter_merge(bf1, bf2);
        XSRETURN_UNDEF;
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

MODULE = CountMin		PACKAGE = bfilter_tPtr PREFIX=bfptr_

SV *
bfptr_DESTROY(bf)
    bfilter_t *bf
    CODE:
        bfilter_free(bf);
        XSRETURN_UNDEF;
    OUTPUT:
        RETVAL
