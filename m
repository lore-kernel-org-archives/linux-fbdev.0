From: Kronos <kronos@people.it>
Subject: Re: [linux-2.6.10] radeonfb / oops
Date: Sat, 12 Feb 2005 18:34:59 +0100
Message-ID: <20050212173459.GA8195@dreamland.darkstar.lan>
References: <200502121639.14542.pluto@pld-linux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D00Em-0006m3-9b
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Feb 2005 08:35:16 -0800
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D00Ej-0003bo-5S
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Feb 2005 08:35:16 -0800
Received: from dreamland.darkstar.lan (84.222.33.119) by mail-relay-3.tiscali.it (7.1.021.3)
        id 4202048800180174 for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Feb 2005 17:34:57 +0100
Content-Disposition: inline
In-Reply-To: <200502121639.14542.pluto@pld-linux.org>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

Il Sat, Feb 12, 2005 at 04:39:14PM +0100, Pawe?? Sikora ha scritto:=20
> > From: Benjamin Herrenschmidt <benh@ke...>
> > Re: Re: [linux-2.6.10] radeonfb / oops  =20
> > 2005-02-03 22:01=20
> >    On Thu, 2005-02-03 at 09:25 +0100, Pawe=B3 Sikora wrote:
> >  > >  > Hi,
> >  > >  >=20
> >  > >  > Could You look at this: http://lkml.org/lkml/2005/1/29/67
> >  > >  > Help will be appreciated.
> >  > >=20
> >  > > From: James Simmons <jsimmons@ww...>
> >  > > Re: [linux-2.6.10] radeonfb / oops  =20
> >  > > 2005-02-01 12:54=20
> >  > >=20
> >  > > Can you post your config?
> >  > > =20
> >  > > On Tue, 1 Feb 2005, Pawel Sikora wrote:
> >  > >=20
> >  >=20
> >  > I"ve tested kernel without grsec and fbsplash and it still oopses.
[...]
> I've removed the old radeonfb and rebuild kernel with debug enabled.
> It still ooopses.

The oops happened somewhere inside fbsplash. Can you send an oops with
vanilla kernel?

> Feb 12 15:56:34 pldworkstation Unable to handle kernel NULL pointer der=
eference at virtual address 00000000
> Feb 12 15:56:34 pldworkstation printing eip:
> Feb 12 15:56:34 pldworkstation c021d31c
> Feb 12 15:56:34 pldworkstation *pgd =3D 0000000009277001
> Feb 12 15:56:34 pldworkstation *pmd =3D 0000000000000000
> Feb 12 15:56:34 pldworkstation Oops: 0002 [#1]
> Feb 12 15:56:34 pldworkstation PREEMPT=20
> Feb 12 15:56:34 pldworkstation Modules linked in: radeonfb i2c_algo_bit=
 i2c_core snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_util_=
mem snd_hwdep radeon button nfs 8139too mii md5 ipv6 ext2 mbcache nfsd ex=
portfs lockd sunrpc via_agp agpgart loop ide_cd cdrom psmouse snd_pcm_oss=
 snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore ide_disk xf=
s via82cxxx ide_core
> Feb 12 15:56:34 pldworkstation CPU:    0
> Feb 12 15:56:34 pldworkstation EIP:    0060:[<c021d31c>]    Not tainted=
 VLI
> Feb 12 15:56:34 pldworkstation EFLAGS: 00010246   (2.6.10-0.106.1)=20
> Feb 12 15:56:34 pldworkstation EIP is at fbsplash_init+0x11c/0x180
                                           ^^^^^^^^^^^^^
Dereferencing NULL pointer inside fbsplash_init.

> Feb 12 15:56:34 pldworkstation eax: c12080cc   ebx: c010dd20   ecx: c03=
2817c   edx: 000000d0
> Feb 12 15:56:34 pldworkstation esi: c010dd21   edi: 00000000   ebp: ca0=
61df4   esp: ca061de0
> Feb 12 15:56:34 pldworkstation ds: 007b   es: 007b   ss: 0068
> Feb 12 15:56:34 pldworkstation Process modprobe (pid: 4245, threadinfo=3D=
ca060000 task=3Dc96b90a0)
> Feb 12 15:56:34 pldworkstation Stack: 00000000 c1208000 00000000 000000=
00 00000000 ca061e04 c021670b 00000001=20
> Feb 12 15:56:34 pldworkstation 00000000 ca061e18 c021b81a 00000000 ca06=
1e54 00000005 ca061e24 c021b878=20
> Feb 12 15:56:34 pldworkstation c03672d8 ca061e38 c015ce0a caf0620c 01d0=
0000 caf06000 ca061ea8 c021faa7=20
> Feb 12 15:56:34 pldworkstation Call Trace:
> Feb 12 15:56:34 pldworkstation [<c013a43a>] show_stack+0x7a/0x90
> Feb 12 15:56:34 pldworkstation [<c013a5bd>] show_registers+0x14d/0x1b0
> Feb 12 15:56:34 pldworkstation [<c013a7a4>] die+0xe4/0x170
> Feb 12 15:56:34 pldworkstation [<c014b23f>] do_page_fault+0x26f/0x761
> Feb 12 15:56:34 pldworkstation [<c013a06b>] error_code+0x2b/0x30
> Feb 12 15:56:34 pldworkstation [<c021670b>] fbcon_takeover+0x9b/0xb0
> Feb 12 15:56:34 pldworkstation [<c021b81a>] fbcon_fb_registered+0x5a/0x=
70
> Feb 12 15:56:34 pldworkstation [<c021b878>] fbcon_event_notify+0x48/0x7=
0
> Feb 12 15:56:34 pldworkstation [<c015ce0a>] notifier_call_chain+0x1a/0x=
30
> Feb 12 15:56:34 pldworkstation [<c021faa7>] register_framebuffer+0x107/=
0x190
> Feb 12 15:56:34 pldworkstation [<d0bea825>] radeonfb_pci_register+0x3a5=
/0x7d0 [radeonfb]
> Feb 12 15:56:34 pldworkstation [<c01f7bc7>] pci_device_probe_static+0x4=
7/0x60
> Feb 12 15:56:34 pldworkstation [<c01f7c11>] __pci_device_probe+0x31/0x5=
0
> Feb 12 15:56:34 pldworkstation [<c01f7c56>] pci_device_probe+0x26/0x40
> Feb 12 15:56:34 pldworkstation [<c02520cc>] driver_probe_device+0x2c/0x=
70
> Feb 12 15:56:34 pldworkstation [<c02521f5>] driver_attach+0x55/0x90
> Feb 12 15:56:34 pldworkstation [<c025268b>] bus_add_driver+0x8b/0xb0
> Feb 12 15:56:34 pldworkstation [<c0252c2b>] driver_register+0x2b/0x30
> Feb 12 15:56:34 pldworkstation [<c01f7e6f>] pci_register_driver+0x5f/0x=
80
> Feb 12 15:56:34 pldworkstation [<c0167978>] sys_init_module+0x148/0x1f0
> Feb 12 15:56:34 pldworkstation [<c0138f29>] sysenter_past_esp+0x52/0x79
> Feb 12 15:56:34 pldworkstation Code: 10 c0 b9 ff ff ff ff 89 f0 89 df f=
2 ae f7 d1 49 89 de 8d 41 01 ba d0 00 00 00 e8 40 8d f5 ff 89 c7 8b 45 f0=
 89 b8 40 01 00 00 ac <aa> 84 c0 75 fa b8 e6 5b 2f c0 31 d2 e8 53 f4 ff f=
f 85 c0 74 0a=20

Disassambling the code:
  2a:   ac                        lods   %ds:(%esi),%al

This decode from eip onwards should be reliable

   0:   aa                        stos   %al,%es:(%edi)   <=3D=3D=3D=3D=3D
   1:   84 c0                     test   %al,%al

So this is a strcpy:

static inline char * strcpy(char * dest,const char *src)
{
int d0, d1, d2;
__asm__ __volatile__(
        "1:\tlodsb\n\t"
        "stosb\n\t"
        "testb %%al,%%al\n\t"
        "jne 1b"
        : "=3D&S" (d0), "=3D&D" (d1), "=3D&a" (d2)
        :"0" (src),"1" (dest) : "memory");
return dest;
}

It looks like this (in fbsplash_init):

                vc->vc_splash.theme =3D kmalloc((strlen(fbsplash_theme)+1=
) * sizeof(char), GFP_KERNEL);
                strcpy(vc->vc_splash.theme, fbsplash_theme);

IMHO kmalloc failed and strcpy used the NULL pointer. Try to change the
code in this way:

vc->vc_splash.theme =3D kmalloc((strlen(fbsplash_theme)+1), GFP_KERNEL);
if (!vc->vc_splash.theme) {
        misc_deregister(&splash_dev);
        printk(KERN_ERR "fbsplash_init: ZOMG!!! Out of mem!\n");
        return -ENOMEM;
}
strcpy(vc->vc_splash.theme, fbsplash_theme);


Luca
--=20
Home: http://kronoz.cjb.net
Let me make your mind, leave yourself behind
Be not afraid


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
