From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 29 Apr 2016 14:07:53 +0000
Subject: Re: [PATCH v4 4/7] fbdev: fb_defio: Export fb_deferred_io_mmap
Message-Id: <57236AB9.5070508@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oeWpVHVLba5ELtSjge2bX7II1wFf5KMwh"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461856717-6476-1-git-send-email-noralf@tronnes.org>
 <1461856717-6476-5-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461856717-6476-5-git-send-email-noralf@tronnes.org>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org

--oeWpVHVLba5ELtSjge2bX7II1wFf5KMwh
Content-Type: multipart/mixed; boundary="suaOR9QxsdlNt0sHbexX8ueVaRvPUlXq3"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
 linux-kernel@vger.kernel.org
Message-ID: <57236AB9.5070508@ti.com>
Subject: Re: [PATCH v4 4/7] fbdev: fb_defio: Export fb_deferred_io_mmap
References: <1461856717-6476-1-git-send-email-noralf@tronnes.org>
 <1461856717-6476-5-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461856717-6476-5-git-send-email-noralf@tronnes.org>

--suaOR9QxsdlNt0sHbexX8ueVaRvPUlXq3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28/04/16 18:18, Noralf Tr=C3=B8nnes wrote:
> Export fb_deferred_io_mmap so drivers can change vma->vm_page_prot.
> When the framebuffer memory is allocated using dma_alloc_writecombine()=

> instead of vmalloc(), I get cache syncing problems on ARM.
> This solves it:
>=20
> static int drm_fbdev_cma_deferred_io_mmap(struct fb_info *info,
> 					  struct vm_area_struct *vma)
> {
> 	fb_deferred_io_mmap(info, vma);
> 	vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);
>=20
> 	return 0;
> }
>=20
> Could this have been done in the core?
> Drivers that don't set (struct fb_ops *)->fb_mmap, gets a call to
> fb_pgprotect() at the end of the default fb_mmap implementation
> (drivers/video/fbdev/core/fbmem.c). This is an architecture specific
> function that on many platforms uses pgprot_writecombine(), but not on
> all. And looking at some of the fb_mmap implementations, some of them
> sets vm_page_prot to nocache for instance, so I think the safest bet is=

> to do this in the driver and not in the fbdev core. And we can't call
> fb_pgprotect() from fb_deferred_io_mmap() either because we don't have
> access to the file pointer that powerpc needs.
>=20
> Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


--suaOR9QxsdlNt0sHbexX8ueVaRvPUlXq3--

--oeWpVHVLba5ELtSjge2bX7II1wFf5KMwh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXI2q5AAoJEPo9qoy8lh71IpIQAK4f/LU/v5YliKkZII9L9oXI
8yncB2TNgwt9u7h+O8pTRMTq1zGSqONvY0LweDSFcGXNEykpuCE1uBvqnA95pkb4
PmEvihtBtJ5ELm4Cj4Cc8q33scLhFoyQFppuE08OBJ86IrTIRKdA3lwkC+FlUfI3
+4hxkdRBbQBWv8SaDULZ6qg+iUU07t6pE7u+i+z4MZShHpN6dcFW/bSMSu2nkogF
dj54WQh2iLU9C6U8ddILRSznFT9kXk7UbW1PW5T2KHt7er/O02wxXVwCFr5OOj94
y/PRC/JTcykAIuItjSC6Il5Zj24oBEjnghgCDnUcunWDOi9mvVc6hqkcUCjg9Zhd
x7IFwobkEUbszswSOd9T/zZpHL00v69soJSHwToTGmf566MHXyqtU27XXghL6/OH
Ggns+oDXHm9FXIDj3ZkWDFF7TLMtD46s48gkAArRQPt8SF/XrJSoTeUWSfoE3ZDV
M8W3HOY8XQaXdAe8cA1xTqQrXwgEtwhnCu+cxPibYd0welDNjEHCEVz1cHxulaH8
2Br+KXif5wNnL0UiT36CA0+YQeNvzQ1v2oSx9mHhP/p8FhOtCv99sRzgnf1SNV/X
zr+9veCtsWlkrG3dIn6nACz/1oNtWUd6VHPymMpTVhlDTS1n7orwN4+CVk8rEs9V
DQ3cTaoI0EfGKFqHdJQG
=Kr6J
-----END PGP SIGNATURE-----

--oeWpVHVLba5ELtSjge2bX7II1wFf5KMwh--
