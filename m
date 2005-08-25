From: =?iso-8859-1?B?cnViZW4gcXVp8W9uZXMgcnVpeg==?= <yosoytelekin@hotmail.com>
Subject: I can't get mapping ram  work  (Arm kernel 2.4 )
Date: Thu, 25 Aug 2005 19:19:38 +0200
Message-ID: <BAY109-F126BB75533BFE132A84B9EC8AB0@phx.gbl>
References: <20050825165333.3D585339DD@sc8-sf-spam1.sourceforge.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8LO7-0004Tj-E4
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 10:19:39 -0700
Received: from bay109-f12.bay109.hotmail.com ([64.4.19.22] helo=hotmail.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E8LO7-0004on-5L
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 10:19:39 -0700
In-Reply-To: <20050825165333.3D585339DD@sc8-sf-spam1.sourceforge.net>
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
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev-devel@lists.sourceforge.net

Hello everybody,

I'm developing a framebuffer display driver with an armv5 based architectur=
e=20
.
I've been able to send commands and display what I want using the Ioctl=20
methods (the display works fine).

But now I want to add the framebuffer funcionality , so I wrote:

static int slcdc_mmap(struct file *filp, struct vm_area_struct *vma)
{
	unsigned long page,pos;
	unsigned long start =3D (unsigned long)vma->vm_start;
	unsigned long size =3D (unsigned long)(vma->vm_end-vma->vm_start);
			printk("\nMMAP CALLED");
	if(size > SLCDC_DATA_MEM_SIZE)
		return -EINVAL;
	pos =3D (unsigned long)slcdc_par.v_screen_start_address;
	while(size>0){
		page =3D virt_to_phys((void*)pos);
		vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
		// This is an IO map - tell maydump to skip this VMA
		vma->vm_flags |=3D VM_IO;
		vma->vm_flags |=3D VM_RESERVED;
		if(remap_page_range(start,page,PAGE_SIZE,PAGE_SHARED)){
					printk("\n\nERRORRRR!!!!!!!!");
			return -EAGAIN;
		}
		start+=3D PAGE_SIZE;
		pos+=3D PAGE_SIZE;
		size-=3D PAGE_SIZE;
	}

	return 0;
}

Where slcdc_par.v_screen_start_address; is the virtual adress of the=20
databuffer that must be sent (via a dma provided by the Cpu).

In user-space:

if((  pMapeo=3D (char *) mmap(NULL, screensize, PROT_READ |=20
PROT_WRITE,MAP_SHARED,fichero,0))=3D=3DNULL)  {
				 printf("Error al proyectar el archivo en memoria\n");
			 	return(4);
   			  }
			  if ((int)pMapeo =3D=3D -1) {
       			 	printf("Error: failed to map device to memory.\n");
    			    exit(4);
  			  }
			  else
			  	printf("\ntoro Ok %x",pMapeo);
			 memset(pMapeo,0xffff,screensize);
			 for (aux=3D0;aux<screensize;aux++){
			 	printf("\n mapeo =3D %d",*(pMapeo+aux));
			 }
			 	aux=3Dioctl(fichero,SLCDC_CMD_RAMWR,&prueba);
I call to mmap and write successfully (printf shows all 0xff ...) and after=
=20
that, I call the RAMWR ioctl:

case SLCDC_CMD_RAMWR:

			printk("RAMWR ");

			for (i=3D0;i<8;i++){
				for (j=3D0;j<127;j++){
					printk("\n Databuffer=3D%d",*(databuffer+i*128+j));
				}

				...send the data...
			}
		break;

Where databuffer is the physical address of=20
slcdc_par.v_screen_start_address;

But, when I run it, printk shows that the memory is filled with 0's instead=
=20
of the data written in user-space...

It seems like remap_page_range didn't work but I've been reading about all =

this process in google and I haven't found the solution to my problem... (i=
f=20
anyone wants to see how I initialize the buffer I'll post it... )

Yours faithfully,
Rub=E9n Qui=F1ones Ruiz -UAH University - Spain




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
