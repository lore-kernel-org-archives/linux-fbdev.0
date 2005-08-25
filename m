From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: I can't get mapping ram  work  (Arm kernel
 2.4 )
Date: Fri, 26 Aug 2005 01:57:07 +0800
Message-ID: <430E0673.4080104@gmail.com>
References: <BAY109-F126BB75533BFE132A84B9EC8AB0@phx.gbl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8Lyg-000647-EO
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 10:57:26 -0700
Received: from wproxy.gmail.com ([64.233.184.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E8Lyf-000839-7K
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 10:57:26 -0700
Received: by wproxy.gmail.com with SMTP id i13so380332wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Aug 2005 10:57:16 -0700 (PDT)
In-Reply-To: <BAY109-F126BB75533BFE132A84B9EC8AB0@phx.gbl>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: =?ISO-8859-1?Q?ruben_qui=F1ones_ruiz?= <yosoytelekin@hotmail.com>

ruben qui=F1ones ruiz wrote:
> Hello everybody,
>=20
> I'm developing a framebuffer display driver with an armv5 based=20
> architecture .
> I've been able to send commands and display what I want using the Ioctl=
=20
> methods (the display works fine).
>=20
> But now I want to add the framebuffer funcionality , so I wrote:
>=20
> static int slcdc_mmap(struct file *filp, struct vm_area_struct *vma)
> {
>     unsigned long page,pos;
>     unsigned long start =3D (unsigned long)vma->vm_start;
>     unsigned long size =3D (unsigned long)(vma->vm_end-vma->vm_start);
>             printk("\nMMAP CALLED");
>     if(size > SLCDC_DATA_MEM_SIZE)
>         return -EINVAL;
>     pos =3D (unsigned long)slcdc_par.v_screen_start_address;
>     while(size>0){
>         page =3D virt_to_phys((void*)pos);
>         vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
>         // This is an IO map - tell maydump to skip this VMA
>         vma->vm_flags |=3D VM_IO;
>         vma->vm_flags |=3D VM_RESERVED;
>         if(remap_page_range(start,page,PAGE_SIZE,PAGE_SHARED)){
>                     printk("\n\nERRORRRR!!!!!!!!");
>             return -EAGAIN;
>         }
>         start+=3D PAGE_SIZE;
>         pos+=3D PAGE_SIZE;
>         size-=3D PAGE_SIZE;
>     }
>=20
>     return 0;
> }
>=20
> Where slcdc_par.v_screen_start_address; is the virtual adress of the=20
> databuffer that must be sent (via a dma provided by the Cpu).

How did you allocate this buffer?  Is is system RAM?  If it's system RAM,
did you use kmalloc, vmalloc or __get_free_pages. (kmalloc, vmalloc usual=
ly
do not work, you have to use __get_free_pages).

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
