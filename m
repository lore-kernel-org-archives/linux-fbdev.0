From: =?iso-8859-1?Q?Martin-=C9ric_Racine?= <q-funk-X3B1VOXEql0@public.gmane.org>
Subject: excessive atyfb debug messages in 2.6.11
Date: Fri, 11 Mar 2005 12:18:57 +0200 (EET)
Message-ID: <Pine.LNX.4.21.0503111206270.32544-100000@hal.pp.fishpool.fi>
Reply-To: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-fbdev-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: linux-fbdev-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:linux-fbdev-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

NOTE: non-subscriber. Please CC replies to me. Thanks!

Hello,

I keep on getting the following both directly to the console and to
several logs (debug, kern.log, messages, syslog), every time I switch
virtual console (this particular exerpt from syslog):

Mar 11 12:05:30 localhost kernel: atyfb: setting up CRTC
Mar 11 12:05:30 localhost kernel: atyfb: set primary CRT to 1024x768 NN com=
posite N
Mar 11 12:05:30 localhost kernel: atyfb: CRTC_H_TOTAL_DISP: 7f00a3
Mar 11 12:05:30 localhost kernel: atyfb: CRTC_H_SYNC_STRT_WID: 2c0083
Mar 11 12:05:30 localhost kernel: atyfb: CRTC_V_TOTAL_DISP: 2ff031f
Mar 11 12:05:30 localhost kernel: atyfb: CRTC_V_SYNC_STRT_WID: 230300
Mar 11 12:05:30 localhost kernel: atyfb: CRTC_OFF_PITCH: 20000000
Mar 11 12:05:30 localhost kernel: atyfb: CRTC_VLINE_CRNT_VLINE: 0
Mar 11 12:05:30 localhost kernel: atyfb: CRTC_GEN_CNTL: b000200
Mar 11 12:05:30 localhost kernel: atyfb: atyfb_set_par
Mar 11 12:05:30 localhost kernel: atyfb:  Set Visible Mode to 1024x768-8
Mar 11 12:05:30 localhost kernel: atyfb:  Virtual resolution 1024x6128, pix=
clock_in_ps 12735 (calculated 12735)
Mar 11 12:05:30 localhost kernel: atyfb:  Dot clock:           78 MHz
Mar 11 12:05:31 localhost kernel: atyfb:  Horizontal sync:     59 kHz
Mar 11 12:05:31 localhost kernel: atyfb:  Vertical refresh:    73 Hz
Mar 11 12:05:31 localhost kernel: atyfb:  x  style: 78.6670 1024 1056 1152 =
1312   768 769 772 800
Mar 11 12:05:31 localhost kernel: atyfb:  fb style: 12735  160 1024 32 96 2=
8 768 1 3
Mar 11 12:05:31 localhost kernel: debug atyfb: Mach64 non-shadow register v=
alues:
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x2000:  007F00A3 002C0083 0=
2FF031F 00230300
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x2010:  01360000 20000000 0=
0000040 0B000200
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x2020:  004A0516 00B004E4 0=
0000000 00000000
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x2030:  00000000 00000000 0=
0000000 0000C400
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x2040:  00000000 00000000 0=
0000000 00000000
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x2050:  00000000 00000000 0=
0000000 00000000
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x2060:  00000000 AAAAAA0F 0=
00BFE00 00000000
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x2070:  00300000 00000000 0=
0003F7C 00000000
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x2080:  00000000 00000000 0=
0000000 00000000
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x2090:  00A63003 40000000 0=
2008000 00000000
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x20A0:  7B23A150 00000000 0=
0000000 65130C01
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x20B0:  00751A79 00010000 0=
0010000 00000000
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x20C0:  00FF0010 87010182 0=
0000000 00000000
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x20D0:  00000188 00000000 0=
0000000 00002042
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x20E0:  7C004750 0080001D 0=
0000000 00000000
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x20F0:  00000000 0000FFEF 8=
08814F8 00000000
Mar 11 12:05:31 localhost kernel:
Mar 11 12:05:31 localhost kernel: debug atyfb: Mach64 PLL register values:
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x00:  ADD51F14 D80341B6 8E9=
EAA01 A61B0000
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x10:  00008000 10ABCC10 000=
00000 00000000
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x20:  ADD51F14 D80341B6 8E9=
EAA01 A61B0000
Mar 11 12:05:31 localhost kernel: debug atyfb: 0x30:  00008000 10ABCC10 000=
00000 00000000
Mar 11 12:05:31 localhost kernel:
Mar 11 12:06:33 localhost kernel: atyfb: setting up CRTC
Mar 11 12:06:33 localhost kernel: atyfb: set primary CRT to 1024x768 NN com=
posite N
Mar 11 12:06:33 localhost kernel: atyfb: CRTC_H_TOTAL_DISP: 7f00a3
Mar 11 12:06:33 localhost kernel: atyfb: CRTC_H_SYNC_STRT_WID: 2c0083
Mar 11 12:06:33 localhost kernel: atyfb: CRTC_V_TOTAL_DISP: 2ff031f
Mar 11 12:06:33 localhost kernel: atyfb: CRTC_V_SYNC_STRT_WID: 230300
Mar 11 12:06:33 localhost kernel: atyfb: CRTC_OFF_PITCH: 20000000
Mar 11 12:06:33 localhost kernel: atyfb: CRTC_VLINE_CRNT_VLINE: 0
Mar 11 12:06:33 localhost kernel: atyfb: CRTC_GEN_CNTL: b000200
Mar 11 12:06:33 localhost kernel: atyfb: atyfb_set_par
Mar 11 12:06:33 localhost kernel: atyfb:  Set Visible Mode to 1024x768-8
Mar 11 12:06:33 localhost kernel: atyfb:  Virtual resolution 1024x6128, pix=
clock_in_ps 12735 (calculated 12735)
Mar 11 12:06:33 localhost kernel: atyfb:  Dot clock:           78 MHz
Mar 11 12:06:33 localhost kernel: atyfb:  Horizontal sync:     59 kHz
Mar 11 12:06:33 localhost kernel: atyfb:  Vertical refresh:    73 Hz
Mar 11 12:06:33 localhost kernel: atyfb:  x  style: 78.6670 1024 1056 1152 =
1312   768 769 772 800
Mar 11 12:06:33 localhost kernel: atyfb:  fb style: 12735  160 1024 32 96 2=
8 768 1 3
Mar 11 12:06:33 localhost kernel: debug atyfb: Mach64 non-shadow register v=
alues:
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x2000:  007F00A3 002C0083 0=
2FF031F 00230300
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x2010:  01340000 20000000 0=
0000040 0B000200
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x2020:  004A0516 00B004E4 0=
0000000 00000000
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x2030:  00000000 00000000 0=
0000000 0000C400
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x2040:  00000000 00000000 0=
0000000 00000000
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x2050:  00000000 00000000 0=
0000000 00000000
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x2060:  00000000 AAAAAA0F 0=
00BFE00 02F00000
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x2070:  00300000 00000000 0=
0003F7C 00000000
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x2080:  00000000 00000000 0=
0000000 00000000
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x2090:  00A63003 40000000 0=
2008000 00000000
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x20A0:  7B23A150 00000000 0=
0000000 65130C01
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x20B0:  00751A79 00010000 0=
0010000 00000000
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x20C0:  00FF0010 87010182 0=
0000000 00000000
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x20D0:  00000108 00000000 0=
0000000 00002042
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x20E0:  7C004750 0080001D 0=
0000000 00000000
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x20F0:  00000000 0000FFEF 8=
08814F8 00000000
Mar 11 12:06:33 localhost kernel:
Mar 11 12:06:33 localhost kernel: debug atyfb: Mach64 PLL register values:
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x00:  ADD51F14 D80341B6 8E9=
EAA01 A61B0000
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x10:  00008000 10ABCC10 000=
00000 00000000
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x20:  ADD51F14 D80341B6 8E9=
EAA01 A61B0000
Mar 11 12:06:33 localhost kernel: debug atyfb: 0x30:  00008000 10ABCC10 000=
00000 00000000
Mar 11 12:06:33 localhost kernel:


This is on an iMac CRT with an ATI 3D Rage Pro 215GP (rev 5c).


Would it be possible for whoever maintains atyfb to remember to disable
debug message output whenever comitting to a release kernel? =20

At the very least, it would be appreciated if those debug messages would
be sent to one and only one syslog channel, instead of spamming whichever
virtual console I happen to be on, plus every syslog channel twice.

Thanks!

--=20
Martin-=C9ric Racine
http://www.iki.fi/q-funk/



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
