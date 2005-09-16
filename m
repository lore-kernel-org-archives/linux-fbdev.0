From: Lior Balkohen <balkohen@gmail.com>
Subject: Re: fbcon woes with closed source framebuffer kernel module
Date: Fri, 16 Sep 2005 18:27:41 +0200
Message-ID: <196b7d310509160927584f8130@mail.gmail.com>
References: <196b7d3105091606241b4d2ba4@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGJ47-0003ir-La
	for Linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Sep 2005 09:27:55 -0700
Received: from nproxy.gmail.com ([64.233.182.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EGJ40-0008LH-9J
	for Linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Sep 2005 09:27:52 -0700
Received: by nproxy.gmail.com with SMTP id a4so196416nfc
        for <Linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 Sep 2005 09:27:42 -0700 (PDT)
In-Reply-To: <196b7d3105091606241b4d2ba4@mail.gmail.com>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: Linux-fbdev-devel@lists.sourceforge.net

>Are you sure fbcon is using your framebuffer?  Check lsmod output.
>If fbcon is using the driver, and your kernel did not crash

telnet 192.168.2.150
Trying 192.168.2.150...
Connected to 192.168.2.150.
Escape character is '^]'.


welcome on your dreambox! - Kernel 2.6.9 (17:49:20).
dreambox login: root
Password:


BusyBox v1.01 (2005.09.08-20:13+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

~ > cd /tmp
/tmp > ls -l *.ko
-rw-r--r--    1 root     root        39224 Sep 16 17:49 fbcon.ko
-rw-r--r--    1 root     root         9236 Sep 16 17:49 font.ko
/tmp > lsmod
Module                  Size  Used by
usbhid 22016 0 - Live 0xc389e000
head 338412 45 - Live 0xc38c9000
/tmp > insmod ./font.ko
/tmp > insmod ./fbcon.ko
/tmp > lsmod
Module                  Size  Used by
fbcon 31732 65 - Live 0xc391d000
font 7008 1 fbcon, Live 0xc3896000
usbhid 22016 0 - Live 0xc389e000
head 338412 46 - Live 0xc38c9000

head is used 45 times and after loading fbcon, 46 times, so i think,
fbcon is using the driver.

>then that closed source driver is already implementing all the drawing
>functions needed by fbcon.

i don't think so:

nm head.ko | grep pfb
000125bc t pfb_check_var
00003a28 d pfb_default
00000000 t pfb_fix
00012c50 t pfb_pan_display
0001edb0 b pfb_pseudo_palette
00012798 t pfb_set_par
00012af4 t pfb_setcolreg

>Check the output of fbset -i and post it here.

/tmp > ./fbset -i

mode "720x576-171"
    # D: 50.000 MHz, H: 54.825 kHz, V: 170.793 Hz
    geometry 720 576 720 576 8
    timings 20000 64 64 32 32 64 2
    laced true
    rgba 8/16,8/8,8/0,8/24
endmode

Frame buffer device information:
    Name        : Pallas FB
    Address     : 0xa0901000
    Size        : 2093056
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 1
    YPanStep    : 1
    YWrapStep   : 1
    LineLength  : 720
    Accelerator : No

>Why don't you ask IBM?
actually, the driver does not come from ibm, but from dream
multimedia, an stb manufacturer, i asked them, and they said, they
cannot answer any questions about drivers because they have a non
disclosure agreement with ibm. ;-)


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
