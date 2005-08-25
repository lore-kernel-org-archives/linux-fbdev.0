From: =?iso-8859-1?B?cnViZW4gcXVp8W9uZXMgcnVpeg==?= <yosoytelekin@hotmail.com>
Subject: Re: I can't get mapping ram work (Arm kernel 2.4 )
Date: Thu, 25 Aug 2005 20:05:05 +0200
Message-ID: <BAY109-F21B4E3CE3F5CC94D769D58C8AB0@phx.gbl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8M66-0006Ng-6X
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 11:05:06 -0700
Received: from bay109-f21.bay109.hotmail.com ([64.4.19.31] helo=hotmail.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E8M66-0005oy-0o
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 11:05:06 -0700
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

TONY wrote:
-----------
How did you allocate this buffer?  Is is system RAM?  If it's system RAM,
did you use kmalloc, vmalloc or __get_free_pages. (kmalloc, vmalloc usually
do not work, you have to use __get_free_pages).
  Tony
---------

Hi Tony, yeah , I use __get_free_pages : (this function is called in int=20
init_module(void) )

int slcdc_init_buffer(void)
{
	u_int required_pages;
	u_int extra_pages;
	u_int order;
	struct page *page;
	u16  *allocated_region;

	printk("slcdc data buffer size =3D %x \n",(unsigned int)SLCDC_DATA_MEM_SIZ=
E);

	if(g_slcdc_dbuffer_address !=3D NULL)
		return -EINVAL;
	if(g_slcdc_cbuffer_address !=3D NULL)
		return -EINVAL;
	/*find order required to allocate enough memory for it*/
	required_pages =3D SLCDC_DATA_MEM_SIZE >> PAGE_SHIFT;
	for (order =3D 0; required_pages >> order; order++){;}
	extra_pages =3D (1 << order) - required_pages;
	printk("PAGE_SHIFT=3D0x%x required_pages=3D0x%x\n",PAGE_SHIFT,required_pag=
es);
	printk("extra_page=3D0x%x \n",extra_pages);

	if((allocated_region =3D	(u_char *)__get_free_pages(GFP_KERNEL | GFP_DMA, =

order)) =3D=3D NULL)
	{
		printk("can not allocated memory\n");
       	return -ENOMEM;
	}

	g_slcdc_dbuffer_address =3D (u_char *)allocated_region + (extra_pages <<=20
PAGE_SHIFT);
	g_slcdc_dbuffer_phyaddress =3D (u_char=20
*)__virt_to_phys((u_long)g_slcdc_dbuffer_address);
	printk("g_slcdc_dbuffer_address=3D0x%x \n",(unsigned=20
int)g_slcdc_dbuffer_address);

    	/* Free all pages that we don't need but were given to us because */
   	 /* __get_free_pages() works on powers of 2. */
   	for (;extra_pages;extra_pages--)
		free_page((u_int)allocated_region + ((extra_pages-1) << PAGE_SHIFT));

	/* Set reserved flag for fb memory to allow it to be remapped into */
	/* user space by the common fbmem driver using remap_page_range(). */
	for(page =3D virt_to_page(g_slcdc_dbuffer_address);
		page < virt_to_page(g_slcdc_dbuffer_address + SLCDC_DATA_MEM_SIZE);
	    page++)
	{
		mem_map_reserve(page);
	}
	slcdc_par.screen_start_address =20
=3D(u_char*)((u_long)g_slcdc_dbuffer_phyaddress);
	slcdc_par.v_screen_start_address=20
=3D(u_char*)((u_long)g_slcdc_dbuffer_address);
	printk("startaddr=3D 0x%x, phyaddr=3D0x%x , size=3D0x%x \n",(unsigned=20
int)slcdc_par.screen_start_address,(unsigned=20
int)slcdc_par.v_screen_start_address,(unsigned int)SLCDC_DATA_MEM_SIZE);
	memset(slcdc_par.v_screen_start_address,0,SLCDC_DATA_MEM_SIZE);

	g_slcdc_cbuffer_address =3D=20
consistent_alloc(GFP_KERNEL|GFP_DMA,(SLCDC_CMD_MEM_SIZE+4),&g_slcdc_cbuffer=
_phyaddress);
	g_slcdc_cbuffer_address =3D (u_long)g_slcdc_cbuffer_address & 0xfffffff4;
	g_slcdc_cbuffer_phyaddress =3D (u_long)g_slcdc_cbuffer_phyaddress &=20
0xfffffff4;

	printk("slcdc data buffer address =3D %x cmd buffer address=3D %x \n",(uns=
igned=20
int)slcdc_par.screen_start_address,(unsigned int) g_slcdc_cbuffer_address);

	return 0;
}

I think , I must have a stupid error that fuck's me.. but I don't find it=20
:-p

Yours Faithfully,
Rub=E9n Qui=F1ones Ruiz -- UAH University -- Spain




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
