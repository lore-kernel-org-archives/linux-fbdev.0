From: "Alan Carvalho" <alancarbr@gmail.com>
Subject: ATI Rage XL with no BIOS support
Date: Tue, 21 Feb 2006 18:29:05 -0300
Message-ID: <dc70db7d0602211329j71a441edg5778e91e012d1299@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3256_7744977.1140557345070"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FBf4P-0004qM-BW
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Feb 2006 13:29:17 -0800
Received: from wproxy.gmail.com ([64.233.184.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FBf4M-0005sn-LJ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Feb 2006 13:29:17 -0800
Received: by wproxy.gmail.com with SMTP id i11so961493wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Feb 2006 13:29:06 -0800 (PST)
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

------=_Part_3256_7744977.1140557345070
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,
I want use ATI Rage XL on an embedded hardware, I see Linux kernel 2.6.x ha=
s
support to initialize this board although Geert Uytterhoeven say me it will
be removed from Linux kernel because it don't work or is broken.

Anyway I am using kernel 2.6.12, it have support initialize Rage XL. I do
some tests, but it don't work, kernel crash (it just stop) at
"aty_st_pll_ct(VCLK0_FB_DIV, 0xDA, par)", I think it is because my board
parameters is incorrect.

I want know how to found all parameter to struct xl_card_cfg_t (xlinit.c) t=
o
make my board work?

static const struct xl_card_cfg_t {
        int ref_crystal; // 10^4 Hz
        int mem_type;
        int mem_size;
        u32 mem_cntl;
        u32 ext_mem_cntl;
        u32 mem_addr_config;
        u32 bus_cntl;
        u32 dac_cntl;
        u32 hw_debug;
        u32 custom_macro_cntl;
        u8  dll2_cntl;
        u8  pll_yclk_cntl;
}

This is my board:
Vendor: 1002
Device: 4752
0000:01:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev
27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage XL
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 9
        Memory at f0000000 (32-bit, non-prefetchable) [size=3D16M]
        I/O ports at a000 [size=3D256]
        Memory at f2000000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [5c] Power Management version 2

Thank you very much,

Alan

------=_Part_3256_7744977.1140557345070
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,<br>
I want use ATI Rage XL on an embedded hardware, I see Linux kernel
2.6.x has support to initialize this board although Geert Uytterhoeven
say me it will be removed from Linux kernel because it don't work or is
broken.<br>
<br>
Anyway I am using kernel 2.6.12, it have support initialize Rage XL. I
do some tests, but it don't work, kernel crash (it just stop) at
&quot;aty_st_pll_ct(VCLK0_FB_DIV, 0xDA, par)&quot;, I think it is because m=
y
board parameters is incorrect.<br>
<br>
I want know how to found all parameter to struct xl_card_cfg_t (xlinit.c) t=
o make my board work?<br>
<br>
static const struct xl_card_cfg_t {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ref_crystal; // 10^4 Hz<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mem_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mem_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mem_cntl;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ext_mem_cntl;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mem_addr_config;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 bus_cntl;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 dac_cntl;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 hw_debug;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 custom_macro_cntl;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8&nbsp; dll2_cntl;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8&nbsp; pll_yclk_cntl;<br>
}<br>
<br>
This is my board:<br>
Vendor: 1002<br>
Device: 4752<br>
0000:01:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 2=
7) (prog-if 00 [VGA])<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: ATI Technologies Inc =
Rage XL<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, stepping, med=
ium devsel, latency 32, IRQ 9<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at f0000000 (32-bit, non-=
prefetchable) [size=3D16M]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at a000 [size=3D256]<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at f2000000 (32-bit, non-=
prefetchable) [size=3D4K]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [5c] Power Managem=
ent version 2<br>
<br>
Thank you very much,<br>
<br>
Alan<br>
<br>
<br>
<br>

------=_Part_3256_7744977.1140557345070--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
