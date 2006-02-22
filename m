From: "Alan Carvalho" <alancarbr@gmail.com>
Subject: Re: Linux-fbdev-devel digest, Vol 1 #1975 - 3 msgs
Date: Wed, 22 Feb 2006 10:01:06 -0300
Message-ID: <dc70db7d0602220501x40412774o3c3aca84ae5810d5@mail.gmail.com>
References: <20060222042715.32C3E33640@sc8-sf-spam1.sourceforge.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3354_10810692.1140613266503"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FBtcG-0004xm-Ep
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Feb 2006 05:01:12 -0800
Received: from wproxy.gmail.com ([64.233.184.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FBtcC-00074Q-Ah
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Feb 2006 05:01:09 -0800
Received: by wproxy.gmail.com with SMTP id 36so111905wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 22 Feb 2006 05:01:07 -0800 (PST)
In-Reply-To: <20060222042715.32C3E33640@sc8-sf-spam1.sourceforge.net>
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
To: linux-fbdev-devel@lists.sourceforge.net

------=_Part_3354_10810692.1140613266503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jay and Richard,
thank you very much.

Jay, I can not execute it because may hardware is powerpc (well I am testin=
g
it on PC before make it work on ppc), then it don't apply, an option is use
x86 emulator, but it is become complicated.

Richard, I don't understant very well, what mother board V1? This source
code is not generic to work on all mother board?

The best option will be contact ATI and ask they about this information, bu=
t
I don't believe they will supply me :-(

Unhappy common video card is bad to use on embedded system because old PC X=
T
legacy.
I need a PCI 3.3V video card to use on Lite5200 board, I know Fujitsu Coral
P support it, but this board can not be found easy on market. I don't know
any other video card that initialize automatic without BIOS support.

Att.

Alan

On 2/22/06, linux-fbdev-devel-request@lists.sourceforge.net <
linux-fbdev-devel-request@lists.sourceforge.net> wrote:
>
> Send Linux-fbdev-devel mailing list submissions to
>         linux-fbdev-devel@lists.sourceforge.net
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> or, via email, send a message with subject or body 'help' to
>         linux-fbdev-devel-request@lists.sourceforge.net
>
> You can reach the person managing the list at
>         linux-fbdev-devel-admin@lists.sourceforge.net
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linux-fbdev-devel digest..."
>
>
> Today's Topics:
>
>    1. ATI Rage XL with no BIOS support (Alan Carvalho)
>    2. Re: ATI Rage XL with no BIOS support (Jay Cotton)
>    3. Re: ATI Rage XL with no BIOS support (Richard Smith)
>
> --__--__--
>
> Message: 1
> Date: Tue, 21 Feb 2006 18:29:05 -0300
> From: "Alan Carvalho" <alancarbr@gmail.com>
> To: linux-fbdev-devel@lists.sourceforge.net
> Subject: [Linux-fbdev-devel] ATI Rage XL with no BIOS support
> Reply-To: linux-fbdev-devel@lists.sourceforge.net
>
> ------=3D_Part_3256_7744977.1140557345070
> Content-Type: text/plain; charset=3DISO-8859-1
> Content-Transfer-Encoding: quoted-printable
> Content-Disposition: inline
>
> Hi all,
> I want use ATI Rage XL on an embedded hardware, I see Linux kernel 2.6.xh=
a=3D
> s
> support to initialize this board although Geert Uytterhoeven say me it
> will
> be removed from Linux kernel because it don't work or is broken.
>
> Anyway I am using kernel 2.6.12, it have support initialize Rage XL. I do
> some tests, but it don't work, kernel crash (it just stop) at
> "aty_st_pll_ct(VCLK0_FB_DIV, 0xDA, par)", I think it is because my board
> parameters is incorrect.
>
> I want know how to found all parameter to struct xl_card_cfg_t (xlinit.c)
> t=3D
> o
> make my board work?
>
> static const struct xl_card_cfg_t {
>         int ref_crystal; // 10^4 Hz
>         int mem_type;
>         int mem_size;
>         u32 mem_cntl;
>         u32 ext_mem_cntl;
>         u32 mem_addr_config;
>         u32 bus_cntl;
>         u32 dac_cntl;
>         u32 hw_debug;
>         u32 custom_macro_cntl;
>         u8  dll2_cntl;
>         u8  pll_yclk_cntl;
> }
>
> This is my board:
> Vendor: 1002
> Device: 4752
> 0000:01:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev
> 27) (prog-if 00 [VGA])
>         Subsystem: ATI Technologies Inc Rage XL
>         Flags: bus master, stepping, medium devsel, latency 32, IRQ 9
>         Memory at f0000000 (32-bit, non-prefetchable) [size=3D3D16M]
>         I/O ports at a000 [size=3D3D256]
>         Memory at f2000000 (32-bit, non-prefetchable) [size=3D3D4K]
>         Capabilities: [5c] Power Management version 2
>
> Thank you very much,
>
> Alan
>
> ------=3D_Part_3256_7744977.1140557345070
> Content-Type: text/html; charset=3DISO-8859-1
> Content-Transfer-Encoding: quoted-printable
> Content-Disposition: inline
>
> Hi all,<br>
> I want use ATI Rage XL on an embedded hardware, I see Linux kernel
> 2.6.x has support to initialize this board although Geert Uytterhoeven
> say me it will be removed from Linux kernel because it don't work or is
> broken.<br>
> <br>
> Anyway I am using kernel 2.6.12, it have support initialize Rage XL. I
> do some tests, but it don't work, kernel crash (it just stop) at
> &quot;aty_st_pll_ct(VCLK0_FB_DIV, 0xDA, par)&quot;, I think it is because
> m=3D
> y
> board parameters is incorrect.<br>
> <br>
> I want know how to found all parameter to struct xl_card_cfg_t (xlinit.c)
> t=3D
> o make my board work?<br>
> <br>
> static const struct xl_card_cfg_t {<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ref_crystal; // 10^4 Hz<br=
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mem_type;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mem_size;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mem_cntl;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ext_mem_cntl;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mem_addr_config;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 bus_cntl;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 dac_cntl;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 hw_debug;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 custom_macro_cntl;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8&nbsp; dll2_cntl;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8&nbsp; pll_yclk_cntl;<br>
> }<br>
> <br>
> This is my board:<br>
> Vendor: 1002<br>
> Device: 4752<br>
> 0000:01:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev
> 2=3D
> 7) (prog-if 00 [VGA])<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: ATI Technologies In=
c
> =3D
> Rage XL<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, stepping,
> med=3D
> ium devsel, latency 32, IRQ 9<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at f0000000 (32-bit,
> non-=3D
> prefetchable) [size=3D3D16M]<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at a000
> [size=3D3D256]<b=3D
> r>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at f2000000 (32-bit,
> non-=3D
> prefetchable) [size=3D3D4K]<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [5c] Power
> Managem=3D
> ent version 2<br>
> <br>
> Thank you very much,<br>
> <br>
> Alan<br>
> <br>
> <br>
> <br>
>
> ------=3D_Part_3256_7744977.1140557345070--
>
>
> --__--__--
>
> Message: 2
> Date: Tue, 21 Feb 2006 12:45:38 -0800
> From: Jay Cotton <Jay.Cotton@Sun.COM>
> Subject: Re: [Linux-fbdev-devel] ATI Rage XL with no BIOS support
> To: linux-fbdev-devel@lists.sourceforge.net
> Reply-To: linux-fbdev-devel@lists.sourceforge.net
>
> Basically you are screwed.
>
> There is a way to fix this, but the code is closed source and ATI will no=
t
> allow it out of there control.  So, unless you can read the bios prom
> into memory and execute the first 1024 bytes in 16bit mode, you will not
> be able to recover.
>
> sorry
>
> JC
>
> Alan Carvalho wrote:
> > Hi all,
> > I want use ATI Rage XL on an embedded hardware, I see Linux kernel 2.6.=
x
> > has support to initialize this board although Geert Uytterhoeven say me
> > it will be removed from Linux kernel because it don't work or is broken=
.
> >
> > Anyway I am using kernel 2.6.12, it have support initialize Rage XL. I
> > do some tests, but it don't work, kernel crash (it just stop) at
> > "aty_st_pll_ct(VCLK0_FB_DIV, 0xDA, par)", I think it is because my boar=
d
> > parameters is incorrect.
> >
> > I want know how to found all parameter to struct xl_card_cfg_t
> > (xlinit.c) to make my board work?
> >
> > static const struct xl_card_cfg_t {
> >         int ref_crystal; // 10^4 Hz
> >         int mem_type;
> >         int mem_size;
> >         u32 mem_cntl;
> >         u32 ext_mem_cntl;
> >         u32 mem_addr_config;
> >         u32 bus_cntl;
> >         u32 dac_cntl;
> >         u32 hw_debug;
> >         u32 custom_macro_cntl;
> >         u8  dll2_cntl;
> >         u8  pll_yclk_cntl;
> > }
> >
> > This is my board:
> > Vendor: 1002
> > Device: 4752
> > 0000:01:01.0 VGA compatible controller: ATI Technologies Inc Rage XL
> > (rev 27) (prog-if 00 [VGA])
> >         Subsystem: ATI Technologies Inc Rage XL
> >         Flags: bus master, stepping, medium devsel, latency 32, IRQ 9
> >         Memory at f0000000 (32-bit, non-prefetchable) [size=3D16M]
> >         I/O ports at a000 [size=3D256]
> >         Memory at f2000000 (32-bit, non-prefetchable) [size=3D4K]
> >         Capabilities: [5c] Power Management version 2
> >
> > Thank you very much,
> >
> > Alan
> >
> >
> >
>
>
> --
>          Jay Cotton                  Jay.Cotton@sun.com
>          MPK17-2348    x80841
>          Sun Microsystems Inc. - X11 Server Group
>          Operating Platform Group
>
>
>
>
> --__--__--
>
> Message: 3
> Date: Tue, 21 Feb 2006 16:53:49 -0600
> From: "Richard Smith" <smithbone@gmail.com>
> To: linux-fbdev-devel@lists.sourceforge.net
> Subject: Re: [Linux-fbdev-devel] ATI Rage XL with no BIOS support
> Reply-To: linux-fbdev-devel@lists.sourceforge.net
>
>
> T24gMi8yMS8wNiwgQWxhbiBDYXJ2YWxobyA8YWxhbmNhcmJyQGdtYWlsLmNvbT4gd3JvdGU6C=
j4g
>
> SGkgYWxsLAo+IEkgd2FudCB1c2UgQVRJIFJhZ2UgWEwgb24gYW4gZW1iZWRkZWQgaGFyZHdhc=
mUs
>
> IEkgc2VlIExpbnV4IGtlcm5lbCAyLjYueCBoYXMKPiBzdXBwb3J0IHRvIGluaXRpYWxpemUgd=
Ghp
>
> cyBib2FyZCBhbHRob3VnaCBHZWVydCBVeXR0ZXJob2V2ZW4gc2F5IG1lIGl0IHdpbGwKPiBiZ=
SBy
>
> ZW1vdmVkIGZyb20gTGludXgga2VybmVsIGJlY2F1c2UgaXQgZG9uJ3Qgd29yayBvciBpcyBic=
m9r
>
> ZW4uCgpZZXAuICBJdCdzIGJyb2tlbiBhbmQgaGFzIGJlZW4gZm9yIHNvbWUgdGltZS4KClRoY=
XQg
>
> Y29kZSB3YXMgb3JnaW5hbGx5IGNyZWF0ZWQgYnkgYSBwZXJzb24gd2l0aCBhIFBDSSBidXMgY=
W5h
>
> bHlzZXIuIApIZSBjYXB0dXJlZCBlYWNoIGFjY2VzcyB0aGUgYmlvcyBtYWRlIHRvIHRoZSB0a=
GUg
>
> Y2FyZCBhbmQgdGhlbiB3cm90ZSBhCmRyaXZlciB0aGF0IHdhcyBlc3NlbnRpYWxseSBhIGJ1b=
mNo
>
> IG9mIElPJ3MgdGhhdCB3b3VsZCBicmluZyB0aGUgY2hpcAp0byBsaWZlLgoKVGhhdCBkcml2Z=
XIg
>
> d2FzIHRoZW4gY29udmVydGVkIGludG8gdGhlIEFUWSBmb3JtYXQgb2YgdGhpbmdzIGZvciAyL=
jYu
>
> eApidXQgSSBkb24ndCBiZWxpZXZlIGl0IGhhcyBldmVyIHdvcmtlZCBzaW5jZSB0aGVuLiAgI=
EFu
>
> ZCBubyBvbmUgaGFzCmV2ZXIgZml4ZWQgaXQuCgo+IEkgd2FudCBrbm93IGhvdyB0byBmb3VuZ=
CBh
>
> bGwgcGFyYW1ldGVyIHRvIHN0cnVjdCB4bF9jYXJkX2NmZ190ICh4bGluaXQuYykgdG8KPiBtY=
Wtl
>
> IG15IGJvYXJkIHdvcms/CgpTb21ld2hlcmUgaW4gdGhlIGFyY2hpdmVzIChWMSBJIHRoaW5rK=
SBp
>
> cyBhIG1vdGhlciBib2FyZCB0aGF0IGhhcyB0aGUKb3JnaW5hbCB3b3JraW5nIGNvcHkgb2Yge=
Gxp
>
> bml0LmMuICBZb3UgY2FuIGFsc28gZ28gZ2V0IGl0IG91dCBvZiB0aGUKMi40Lngga2VybmVsL=
goK
>
> QW5vdGhlciBvcHRpb24gaXMgdG8gcmVnaXN0ZXIgYXMgYSBkZXZlbG9wZXIgb24gQVRJJ3Mgc=
2l0
>
> ZSBhbmQgZ2V0IHRoZQpkb2NzIGZvciB0aGUgUmFnZSBYTC4gIFRoYXQgY291cGxlZCB3aXRoI=
HRo
>
> ZSB4bGluaXQuYyBzaG91bGQgYWxsb3cgeW91CmZpeHVwIHlvdXIgcHJvYmxlbXMuCgotLQpSa=
WNo
> YXJkIEEuIFNtaXRoCg=3D=3D
>
>
>
> --__--__--
>
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>
>
> End of Linux-fbdev-devel Digest
>

------=_Part_3354_10810692.1140613266503
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jay and Richard,<br>
thank you very much.<br>
<br>
Jay, I can not execute it because may hardware is powerpc (well I am
testing it on PC before make it work on ppc), then it don't apply, an
option is use x86 emulator, but it is become complicated.<br><br>
Richard, I don't understant very well, what mother board V1? This source co=
de is not generic to work on all mother board?<br>
<br>
The best option will be contact ATI and ask they about this information, bu=
t I don't believe they will supply me :-(<br>
<br>
Unhappy common video card is bad to use on embedded system because old PC X=
T legacy.<br>
I need a PCI 3.3V video card to use on Lite5200 board, I know Fujitsu
Coral P support it, but this board can not be found easy on market. I
don't know any other video card that initialize automatic without BIOS
support.<br>
<br>
Att.<br>
<br>
Alan<br>
<br><div><span class=3D"gmail_quote">On 2/22/06, <b class=3D"gmail_senderna=
me"><a href=3D"mailto:linux-fbdev-devel-request@lists.sourceforge.net">linu=
x-fbdev-devel-request@lists.sourceforge.net</a></b> &lt;<a href=3D"mailto:l=
inux-fbdev-devel-request@lists.sourceforge.net">
linux-fbdev-devel-request@lists.sourceforge.net</a>&gt; wrote:</span><block=
quote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 2=
04); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Send Linux-fbdev-devel =
mailing list submissions to
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=3D"mailto:linux=
-fbdev-devel@lists.sourceforge.net">linux-fbdev-devel@lists.sourceforge.net=
</a><br><br>To subscribe or unsubscribe via the World Wide Web, visit<br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=3D"https://lists.sour=
ceforge.net/lists/listinfo/linux-fbdev-devel">
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel</a><br>or, v=
ia email, send a message with subject or body 'help' to<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=3D"mailto:linux-fbdev-devel-request=
@lists.sourceforge.net">linux-fbdev-devel-request@lists.sourceforge.net
</a><br><br>You can reach the person managing the list at<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=3D"mailto:linux-fbdev-devel-admin=
@lists.sourceforge.net">linux-fbdev-devel-admin@lists.sourceforge.net</a><b=
r><br>When replying, please edit your Subject line so it is more specific
<br>than &quot;Re: Contents of Linux-fbdev-devel digest...&quot;<br><br><br=
>Today's Topics:<br><br>&nbsp;&nbsp; 1. ATI Rage XL with no BIOS support (A=
lan Carvalho)<br>&nbsp;&nbsp; 2. Re: ATI Rage XL with no BIOS support (Jay =
Cotton)<br>&nbsp;&nbsp; 3. Re: ATI Rage XL with no BIOS support (Richard Sm=
ith)
<br><br>--__--__--<br><br>Message: 1<br>Date: Tue, 21 Feb 2006 18:29:05 -03=
00<br>From: &quot;Alan Carvalho&quot; &lt;<a href=3D"mailto:alancarbr@gmail=
.com">alancarbr@gmail.com</a>&gt;<br>To: <a href=3D"mailto:linux-fbdev-deve=
l@lists.sourceforge.net">
linux-fbdev-devel@lists.sourceforge.net</a><br>Subject: [Linux-fbdev-devel]=
 ATI Rage XL with no BIOS support<br>Reply-To: <a href=3D"mailto:linux-fbde=
v-devel@lists.sourceforge.net">linux-fbdev-devel@lists.sourceforge.net</a>
<br><br>------=3D_Part_3256_7744977.1140557345070<br>Content-Type: text/pla=
in; charset=3DISO-8859-1<br>Content-Transfer-Encoding: quoted-printable<br>=
Content-Disposition: inline<br><br>Hi all,<br>I want use ATI Rage XL on an =
embedded hardware, I see Linux kernel=20
2.6.x ha=3D<br>s<br>support to initialize this board although Geert Uytterh=
oeven say me it will<br>be removed from Linux kernel because it don't work =
or is broken.<br><br>Anyway I am using kernel 2.6.12, it have support initi=
alize Rage XL. I do
<br>some tests, but it don't work, kernel crash (it just stop) at<br>&quot;=
aty_st_pll_ct(VCLK0_FB_DIV, 0xDA, par)&quot;, I think it is because my boar=
d<br>parameters is incorrect.<br><br>I want know how to found all parameter=
 to struct xl_card_cfg_t (
xlinit.c) t=3D<br>o<br>make my board work?<br><br>static const struct xl_ca=
rd_cfg_t {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int ref_cryst=
al; // 10^4 Hz<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int mem_t=
ype;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int mem_size;<br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;u32 mem_cntl;<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;u32 ext_mem_cntl;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;u32 mem_addr_config;<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;u32 bus_cntl;<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;u32 dac_cntl;<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;u32 hw_debug;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;u32 custom_macro_cntl;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;u8&nbsp;&nbsp;dll2_cntl;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;u8&nbsp;&nbsp;pll_yclk_cntl;<br>}<br><br>This is my boar=
d:
<br>Vendor: 1002<br>Device: 4752<br>0000:01:01.0 VGA compatible controller:=
 ATI Technologies Inc Rage XL (rev<br>27) (prog-if 00 [VGA])<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subsystem: ATI Technologies Inc Rage X=
L<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Flags: bus master, ste=
pping, medium devsel, latency 32, IRQ 9
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Memory at f0000000 (32-=
bit, non-prefetchable) [size=3D3D16M]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;I/O ports at a000 [size=3D3D256]<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;Memory at f2000000 (32-bit, non-prefetchable) [size=
=3D3D4K]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Capabilities: [=
5c] Power Management version 2
<br><br>Thank you very much,<br><br>Alan<br><br>------=3D_Part_3256_7744977=
.1140557345070<br>Content-Type: text/html; charset=3DISO-8859-1<br>Content-=
Transfer-Encoding: quoted-printable<br>Content-Disposition: inline<br><br>H=
i all,&lt;br&gt;
<br>I want use ATI Rage XL on an embedded hardware, I see Linux kernel<br>2=
.6.x has support to initialize this board although Geert Uytterhoeven<br>sa=
y me it will be removed from Linux kernel because it don't work or is<br>
broken.&lt;br&gt;<br>&lt;br&gt;<br>Anyway I am using kernel 2.6.12, it have=
 support initialize Rage XL. I<br>do some tests, but it don't work, kernel =
crash (it just stop) at<br>&amp;quot;aty_st_pll_ct(VCLK0_FB_DIV, 0xDA, par)=
&amp;quot;, I think it is because m=3D
<br>y<br>board parameters is incorrect.&lt;br&gt;<br>&lt;br&gt;<br>I want k=
now how to found all parameter to struct xl_card_cfg_t (xlinit.c) t=3D<br>o=
 make my board work?&lt;br&gt;<br>&lt;br&gt;<br>static const struct xl_card=
_cfg_t {&lt;br&gt;
<br>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; =
int ref_crystal; // 10^4 Hz&lt;br&gt;<br>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp=
;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; int mem_type;&lt;br&gt;<br>&amp;nbsp;&=
amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; int mem_size;&l=
t;br&gt;
<br>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; =
u32 mem_cntl;&lt;br&gt;<br>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbs=
p;&amp;nbsp;&amp;nbsp; u32 ext_mem_cntl;&lt;br&gt;<br>&amp;nbsp;&amp;nbsp;&=
amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; u32 mem_addr_config;&lt;b=
r&gt;
<br>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; =
u32 bus_cntl;&lt;br&gt;<br>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbs=
p;&amp;nbsp;&amp;nbsp; u32 dac_cntl;&lt;br&gt;<br>&amp;nbsp;&amp;nbsp;&amp;=
nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; u32 hw_debug;&lt;br&gt;
<br>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; =
u32 custom_macro_cntl;&lt;br&gt;<br>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp=
;&amp;nbsp;&amp;nbsp;&amp;nbsp; u8&amp;nbsp; dll2_cntl;&lt;br&gt;<br>&amp;n=
bsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; u8&amp;nbs=
p; pll_yclk_cntl;&lt;br&gt;
<br>}&lt;br&gt;<br>&lt;br&gt;<br>This is my board:&lt;br&gt;<br>Vendor: 100=
2&lt;br&gt;<br>Device: 4752&lt;br&gt;<br>0000:01:01.0 VGA compatible contro=
ller: ATI Technologies Inc Rage XL (rev 2=3D<br>7) (prog-if 00 [VGA])&lt;br=
&gt;
<br>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; =
Subsystem: ATI Technologies Inc =3D<br>Rage XL&lt;br&gt;<br>&amp;nbsp;&amp;=
nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; Flags: bus master, =
stepping, med=3D
<br>ium devsel, latency 32, IRQ 9&lt;br&gt;<br>&amp;nbsp;&amp;nbsp;&amp;nbs=
p;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; Memory at f0000000 (32-bit, non-=
=3D<br>prefetchable) [size=3D3D16M]&lt;br&gt;<br>&amp;nbsp;&amp;nbsp;&amp;n=
bsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; I/O ports at a000 [size=3D3D25=
6]&lt;b=3D
<br>r&gt;<br>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&a=
mp;nbsp; Memory at f2000000 (32-bit, non-=3D<br>prefetchable) [size=3D3D4K]=
&lt;br&gt;<br>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&=
amp;nbsp; Capabilities: [5c] Power Managem=3D
<br>ent version 2&lt;br&gt;<br>&lt;br&gt;<br>Thank you very much,&lt;br&gt;=
<br>&lt;br&gt;<br>Alan&lt;br&gt;<br>&lt;br&gt;<br>&lt;br&gt;<br>&lt;br&gt;<=
br><br>------=3D_Part_3256_7744977.1140557345070--<br><br><br>--__--__--<br=
>
<br>Message: 2<br>Date: Tue, 21 Feb 2006 12:45:38 -0800<br>From: Jay Cotton=
 &lt;<a href=3D"mailto:Jay.Cotton@Sun.COM">Jay.Cotton@Sun.COM</a>&gt;<br>Su=
bject: Re: [Linux-fbdev-devel] ATI Rage XL with no BIOS support<br>To: <a h=
ref=3D"mailto:linux-fbdev-devel@lists.sourceforge.net">
linux-fbdev-devel@lists.sourceforge.net</a><br>Reply-To: <a href=3D"mailto:=
linux-fbdev-devel@lists.sourceforge.net">linux-fbdev-devel@lists.sourceforg=
e.net</a><br><br>Basically you are screwed.<br><br>There is a way to fix th=
is, but the code is closed source and ATI will not
<br>allow it out of there control.&nbsp;&nbsp;So, unless you can read the b=
ios prom<br>into memory and execute the first 1024 bytes in 16bit mode, you=
 will not<br>be able to recover.<br><br>sorry<br><br>JC<br><br>Alan Carvalh=
o wrote:
<br>&gt; Hi all,<br>&gt; I want use ATI Rage XL on an embedded hardware, I =
see Linux kernel 2.6.x<br>&gt; has support to initialize this board althoug=
h Geert Uytterhoeven say me<br>&gt; it will be removed from Linux kernel be=
cause it don't work or is broken.
<br>&gt;<br>&gt; Anyway I am using kernel 2.6.12, it have support initializ=
e Rage XL. I<br>&gt; do some tests, but it don't work, kernel crash (it jus=
t stop) at<br>&gt; &quot;aty_st_pll_ct(VCLK0_FB_DIV, 0xDA, par)&quot;, I th=
ink it is because my board
<br>&gt; parameters is incorrect.<br>&gt;<br>&gt; I want know how to found =
all parameter to struct xl_card_cfg_t<br>&gt; (xlinit.c) to make my board w=
ork?<br>&gt;<br>&gt; static const struct xl_card_cfg_t {<br>&gt;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ref_crystal; // 10^4 Hz
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mem_type;<br>&=
gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mem_size;<br>&gt;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mem_cntl;<br>&gt;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ext_mem_cntl;<br>&gt;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mem_addr_config;<br>&gt;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 bus_cntl;<br>&gt;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 dac_cntl;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 hw_debug;<br>&=
gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 custom_macro_cntl;<=
br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp;dll2_=
cntl;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp=
;pll_yclk_cntl;<br>&gt; }<br>&gt;<br>&gt; This is my board:<br>&gt; Vendor:=
 1002<br>&gt; Device: 4752
<br>&gt; 0000:01:01.0 VGA compatible controller: ATI Technologies Inc Rage =
XL<br>&gt; (rev 27) (prog-if 00 [VGA])<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; Subsystem: ATI Technologies Inc Rage XL<br>&gt;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, stepping, mediu=
m devsel, latency 32, IRQ 9
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at f0000000=
 (32-bit, non-prefetchable) [size=3D16M]<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; I/O ports at a000 [size=3D256]<br>&gt;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at f2000000 (32-bit, non-prefetcha=
ble) [size=3D4K]<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ca=
pabilities: [5c] Power Management version 2
<br>&gt;<br>&gt; Thank you very much,<br>&gt;<br>&gt; Alan<br>&gt;<br>&gt;<=
br>&gt;<br><br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Jay
Cotton&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=3D"mailto:Jay.Cotton@sun.com=
">Jay.Cotton@sun.com</a><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; MPK17-2348&nbsp;&nbsp;&nbsp;&nbsp;x80841<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; Sun Microsystems Inc. - X11 Server Group<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Operating Platform Group<br><br><br><=
br>
<br>--__--__--<br><br>Message: 3<br>Date: Tue, 21 Feb 2006 16:53:49 -0600<b=
r>From: &quot;Richard Smith&quot; &lt;<a href=3D"mailto:smithbone@gmail.com=
">smithbone@gmail.com</a>&gt;<br>To: <a href=3D"mailto:linux-fbdev-devel@li=
sts.sourceforge.net">
linux-fbdev-devel@lists.sourceforge.net</a><br>Subject: Re: [Linux-fbdev-de=
vel] ATI Rage XL with no BIOS support<br>Reply-To: <a href=3D"mailto:linux-=
fbdev-devel@lists.sourceforge.net">linux-fbdev-devel@lists.sourceforge.net
</a><br><br>T24gMi8yMS8wNiwgQWxhbiBDYXJ2YWxobyA8YWxhbmNhcmJyQGdtYWlsLmNvbT4=
gd3JvdGU6Cj4g<br>SGkgYWxsLAo+IEkgd2FudCB1c2UgQVRJIFJhZ2UgWEwgb24gYW4gZW1iZW=
RkZWQgaGFyZHdhcmUs<br>IEkgc2VlIExpbnV4IGtlcm5lbCAyLjYueCBoYXMKPiBzdXBwb3J0I=
HRvIGluaXRpYWxpemUgdGhp
<br>cyBib2FyZCBhbHRob3VnaCBHZWVydCBVeXR0ZXJob2V2ZW4gc2F5IG1lIGl0IHdpbGwKPiB=
iZSBy<br>ZW1vdmVkIGZyb20gTGludXgga2VybmVsIGJlY2F1c2UgaXQgZG9uJ3Qgd29yayBvci=
BpcyBicm9r<br>ZW4uCgpZZXAuICBJdCdzIGJyb2tlbiBhbmQgaGFzIGJlZW4gZm9yIHNvbWUgd=
GltZS4KClRoYXQg
<br>Y29kZSB3YXMgb3JnaW5hbGx5IGNyZWF0ZWQgYnkgYSBwZXJzb24gd2l0aCBhIFBDSSBidXM=
gYW5h<br>bHlzZXIuIApIZSBjYXB0dXJlZCBlYWNoIGFjY2VzcyB0aGUgYmlvcyBtYWRlIHRvIH=
RoZSB0aGUg<br>Y2FyZCBhbmQgdGhlbiB3cm90ZSBhCmRyaXZlciB0aGF0IHdhcyBlc3NlbnRpY=
WxseSBhIGJ1bmNo
<br>IG9mIElPJ3MgdGhhdCB3b3VsZCBicmluZyB0aGUgY2hpcAp0byBsaWZlLgoKVGhhdCBkcml=
2ZXIg<br>d2FzIHRoZW4gY29udmVydGVkIGludG8gdGhlIEFUWSBmb3JtYXQgb2YgdGhpbmdzIG=
ZvciAyLjYu<br>eApidXQgSSBkb24ndCBiZWxpZXZlIGl0IGhhcyBldmVyIHdvcmtlZCBzaW5jZ=
SB0aGVuLiAgIEFu
<br>ZCBubyBvbmUgaGFzCmV2ZXIgZml4ZWQgaXQuCgo+IEkgd2FudCBrbm93IGhvdyB0byBmb3V=
uZCBh<br>bGwgcGFyYW1ldGVyIHRvIHN0cnVjdCB4bF9jYXJkX2NmZ190ICh4bGluaXQuYykgdG=
8KPiBtYWtl<br>IG15IGJvYXJkIHdvcms/CgpTb21ld2hlcmUgaW4gdGhlIGFyY2hpdmVzIChWM=
SBJIHRoaW5rKSBp
<br>cyBhIG1vdGhlciBib2FyZCB0aGF0IGhhcyB0aGUKb3JnaW5hbCB3b3JraW5nIGNvcHkgb2Y=
geGxp<br>bml0LmMuICBZb3UgY2FuIGFsc28gZ28gZ2V0IGl0IG91dCBvZiB0aGUKMi40Lngga2=
VybmVsLgoK<br>QW5vdGhlciBvcHRpb24gaXMgdG8gcmVnaXN0ZXIgYXMgYSBkZXZlbG9wZXIgb=
24gQVRJJ3Mgc2l0
<br>ZSBhbmQgZ2V0IHRoZQpkb2NzIGZvciB0aGUgUmFnZSBYTC4gIFRoYXQgY291cGxlZCB3aXR=
oIHRo<br>ZSB4bGluaXQuYyBzaG91bGQgYWxsb3cgeW91CmZpeHVwIHlvdXIgcHJvYmxlbXMuCg=
otLQpSaWNo<br>YXJkIEEuIFNtaXRoCg=3D=3D<br><br><br><br>--__--__--<br><br>___=
____________________________________________
<br>Linux-fbdev-devel mailing list<br><a href=3D"mailto:Linux-fbdev-devel@l=
ists.sourceforge.net">Linux-fbdev-devel@lists.sourceforge.net</a><br><a hre=
f=3D"https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel">https:=
//lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
</a><br><br><br>End of Linux-fbdev-devel Digest<br></blockquote></div><br>

------=_Part_3354_10810692.1140613266503--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
