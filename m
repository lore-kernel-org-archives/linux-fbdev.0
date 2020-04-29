From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 29 Apr 2020 12:06:57 +0000
Subject: Re: [PATCH v2] video: fbdev: controlfb: fix build for COMPILE_TEST=y && PPC_PMAC=y && PPC32=n
Message-Id: <28839ddd-36bb-3a69-b3dc-9dc14ac7eaee@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200429104825eucas1p16bf37b71a3ab3a768d1eff6c48eb61dd@eucas1p1.samsung.com>
 <fe520316-3863-e6c4-9581-5d709f49e906@samsung.com>
 <20200429115417.GA12801@ravnborg.org>
In-Reply-To: <20200429115417.GA12801@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-fbdev@vger.kernel.org, kbuild test robot <lkp@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>


On 4/29/20 1:54 PM, Sam Ravnborg wrote:
> Hi Bartlomiej.
> 
> On Wed, Apr 29, 2020 at 12:48:24PM +0200, Bartlomiej Zolnierkiewicz wrote:
>>
>> powerpc allyesconfig fails like this:
>>
>> drivers/video/fbdev/controlfb.c: In function 'controlfb_mmap':
>> drivers/video/fbdev/controlfb.c:756:23: error: implicit declaration of function 'pgprot_cached_wthru'; did you mean 'pgprot_cached'? [-Werror=implicit-function-declaration]
>>   756 |   vma->vm_page_prot = pgprot_cached_wthru(vma->vm_page_prot);
>>       |                       ^~~~~~~~~~~~~~~~~~~
>>       |                       pgprot_cached
>> drivers/video/fbdev/controlfb.c:756:23: error: incompatible types when assigning to type 'pgprot_t' {aka 'struct <anonymous>'} from type 'int'
>>
>> Fix it by adding missing PPC32 dependency.
> 
> Is this really the right fix?

Yes, ifdef in the code should match driver dependencies in Kconfig:

config FB_CONTROL
        bool "Apple \"control\" display support"
        depends on (FB = y) && ((PPC_PMAC && PPC32) || COMPILE_TEST)

> Short term I htink it is OK, but I think there should be a common way
> to do the same for all archtectures so no conditional compilation is
> needed. In other words the use of pgprot_cached_wthru looks like we
> need a better abstraction.

This would be of course nice to have but won't be enough to remove
the ifdef in this particular driver.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Added Christoph to the mail as he has a good overview of the area.
> 
> 	Sam
> 
> 
>>
>> Fixes: a07a63b0e24d ("video: fbdev: controlfb: add COMPILE_TEST support")
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Cc: Sam Ravnborg <sam@ravnborg.org>
>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>> v2: fix implicit btext_update_display() function declaration error
>>
>>  drivers/video/fbdev/controlfb.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Index: b/drivers/video/fbdev/controlfb.c
>> =================================>> --- a/drivers/video/fbdev/controlfb.c
>> +++ b/drivers/video/fbdev/controlfb.c
>> @@ -55,7 +55,7 @@
>>  #include "macmodes.h"
>>  #include "controlfb.h"
>>  
>> -#ifndef CONFIG_PPC_PMAC
>> +#if !defined(CONFIG_PPC_PMAC) || !defined(CONFIG_PPC32)
>>  #define invalid_vram_cache(addr)
>>  #undef in_8
>>  #undef out_8
> 
>
