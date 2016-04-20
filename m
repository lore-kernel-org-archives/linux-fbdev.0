From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Wed, 20 Apr 2016 18:33:17 +0000
Subject: Re: [PATCH 5/8] fbdev: fb_defio: Export fb_deferred_io_mmap
Message-Id: <5717CB6D.8000708@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
 <1461165929-11344-6-git-send-email-noralf@tronnes.org>
 <20160420174414.GQ2510@phenom.ffwll.local>
In-Reply-To: <20160420174414.GQ2510@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, laurent.pinchart@ideasonboard.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


Den 20.04.2016 19:44, skrev Daniel Vetter:
> On Wed, Apr 20, 2016 at 05:25:26PM +0200, Noralf Tr=F8nnes wrote:
>> Export fb_deferred_io_mmap so drivers can change vma->vm_page_prot.
>> When the framebuffer memory is allocated using dma_alloc_writecombine()
>> instead of vmalloc(), I get cache syncing problems.
>> This solves it:
>>
>> static int drm_fbdev_cma_deferred_io_mmap(struct fb_info *info,
>> 					  struct vm_area_struct *vma)
>> {
>> 	fb_deferred_io_mmap(info, vma);
>> 	vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);
> Hm, do we need pgpropt_writecombine? There recently was some discussion
> (on the arc platform) that fbdev pgprots need to be fixed up in fbdev
> code. I have no idea, just repeating from memory ...

I need it or else I get partial lines that doesn't get updated on the=20
display.
fbdev code that doesn't set (struct fb_ops *)->fb_mmap, gets this for free
in the default fb_mmap implementation (drivers/video/fbdev/core/fbmem.c).
It calls fb_pgprotect() at the end which is an architecture specific
function that on many platforms uses pgprot_writecombine(), but not on all.
And looking at some of the fb_mmap implementations, some of them sets
vm_page_prot to nocache for instance, so I think the safest bet is to do
this here and not in the fbdev core. And we can't call fb_pgprotect() from
fb_deferred_io_mmap() either because we don't have access to the file
pointer that powerpc needs.
I think the case you refer to was solved with using fb_pgprotect() for
the platform in question and it didn't involve deferred io.

> -Daniel
>
>> 	return 0;
>> }
>>
>> Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>
>> ---
>>   drivers/video/fbdev/core/fb_defio.c | 3 ++-
>>   include/linux/fb.h                  | 1 +
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/c=
ore/fb_defio.c
>> index 57721c7..74b5bca 100644
>> --- a/drivers/video/fbdev/core/fb_defio.c
>> +++ b/drivers/video/fbdev/core/fb_defio.c
>> @@ -164,7 +164,7 @@ static const struct address_space_operations fb_defe=
rred_io_aops =3D {
>>   	.set_page_dirty =3D fb_deferred_io_set_page_dirty,
>>   };
>>  =20
>> -static int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_str=
uct *vma)
>> +int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vm=
a)
>>   {
>>   	vma->vm_ops =3D &fb_deferred_io_vm_ops;
>>   	vma->vm_flags |=3D VM_DONTEXPAND | VM_DONTDUMP;
>> @@ -173,6 +173,7 @@ static int fb_deferred_io_mmap(struct fb_info *info,=
 struct vm_area_struct *vma)
>>   	vma->vm_private_data =3D info;
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL(fb_deferred_io_mmap);
>>  =20
>>   /* workqueue callback */
>>   static void fb_deferred_io_work(struct work_struct *work)
>> diff --git a/include/linux/fb.h b/include/linux/fb.h
>> index dfe8835..a964d07 100644
>> --- a/include/linux/fb.h
>> +++ b/include/linux/fb.h
>> @@ -673,6 +673,7 @@ static inline void __fb_pad_aligned_buffer(u8 *dst, =
u32 d_pitch,
>>   }
>>  =20
>>   /* drivers/video/fb_defio.c */
>> +int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vm=
a);
>>   extern void fb_deferred_io_init(struct fb_info *info);
>>   extern void fb_deferred_io_open(struct fb_info *info,
>>   				struct inode *inode,
>> --=20
>> 2.2.2
>>

