From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Text console scrolling
Date: Wed, 18 Jul 2007 17:10:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0707181708020.15632@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1488949865-1184771429=:15632"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBBAk-0006QC-Qf for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 08:10:39 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IBBAj-0000in-4U
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 08:10:38 -0700
Received: from pademelon.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 1EB2558ABD
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 18 Jul 2007 17:10:30 +0200 (MEST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1488949865-1184771429=:15632
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

	Hi all,

I was trying to find the optimal scrolling strategy for ps3fb just when m=
any
fbcon changes went in, and I want to share my findings with you.

Below are the results for my text console scrolling benchmark (execution =
time
in seconds of cat'ing a big text file) on the PS3, for various video mode=
s,
screen rotations (you can fit lots of debug output on a rotated 1920x1200
screen ;-), and font, using the default FBINFO_DEFAULT vs.
FBINFO_DEFAULT | FBINFO_READS_FAST flags.

2.6.22-ga5fcaa21 is mainline from yesterday, 2.6.22-gcb32da04 is mainline=
 from
today:

				2.6.22-ga5fcaa21	2.6.22-gcb32da04
mode	rot	font		DEFAULT	READS_FAST	DEFAULT	READS_FAST
480p	0	default8x16	 7.32	 6.63		 7.49	 5.18
480p	1	default8x16	11.39	 5.79		11.60	 7.60	=09
480p	2	default8x16	 7.35	 4.34		 7.50	 3.90	=09
480p	3	default8x16	11.39	 8.85		11.61	 9.31	=09
720p	0	default8x16	13.04	15.91		13.33	 9.28	=09
720p	1	default8x16	22.76	12.73		23.17	18.35	=09
720p	2	default8x16	13.10	10.22		13.34	 7.30	=09
720p	3	default8x16	22.60	19.65		23.03	19.56	=09
1080p	0	default8x16	20.76	34.25		21.09	14.98	=09
1080p	1	default8x16	35.13	23.82		35.78	26.27	=09
1080p	2	default8x16	20.69	21.51		21.12	11.57	=09
1080p	3	default8x16	34.98	37.03		35.68	29.23	=09
WUXGA	0	default8x16	24.92	46.83		25.52	18.05	=09
WUXGA	1	default8x16	41.19	31.08		41.98	28.61	=09
WUXGA	2	default8x16	25.00	29.11		25.56	13.74	=09
WUXGA	3	default8x16	41.20	49.49		42.02	34.79	=09
480p	0	lat4-19		 7.20	 6.57		 7.35	 5.12	=09
480p	1	lat4-19		11.19	 6.02		11.36	 7.86	=09
480p	2	lat4-19		 7.21	 4.32		 7.36	 3.83	=09
480p	3	lat4-19		11.12	 8.90		11.33	 9.08	=09
720p	0	lat4-19		12.69	15.57		12.94	 9.09	=09
720p	1	lat4-19		22.43	12.92		22.86	17.46	=09
720p	2	lat4-19		12.71	10.04		13.08	 7.19	=09
720p	3	lat4-19		22.50	20.02		22.89	20.21	=09
1080p	0	lat4-19		20.31	33.99		20.75	14.87	=09
1080p	1	lat4-19		34.60	24.06		35.26	25.19	=09
1080p	2	lat4-19		20.39	21.37		20.79	11.51	=09
1080p	3	lat4-19		34.50	37.45		35.24	29.13	=09
WUXGA	0	lat4-19		24.72	46.92		25.26	18.06	=09
WUXGA	1	lat4-19		40.98	32.32		41.77	30.52	=09
WUXGA	2	lat4-19		24.80	29.13		25.28	13.73	=09
WUXGA	3	lat4-19		41.25	50.26		42.25	35.50	=09

Yesterday, FBINFO_READS_FAST was faster in some cases, but much slower in
others, so I didn't really know whether I should enable it or not.

Today, FBINFO_READS_FAST is faster in all test cases, so the choice is cl=
ear.

Note that there are still a few cases where today's fastest option is a b=
it
slower than yesterday's fastest option.

With kind regards,
=20
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village =C2=B7 Da Vincilaan 7-D1 =C2=B7 B-1935 Zaventem =C2=
=B7 Belgium
=20
Phone:    +32 (0)2 700 8453=09
Fax:      +32 (0)2 700 8622=09
E-mail:   Geert.Uytterhoeven@sonycom.com=09
Internet: http://www.sony-europe.com/
 =09
Sony Network and Software Technology Center Europe=09
A division of Sony Service Centre (Europe) N.V.=09
Registered office: Technologielaan 7 =C2=B7 B-1840 Londerzeel =C2=B7 Belg=
ium=09
VAT BE 0413.825.160 =C2=B7 RPR Brussels=09
Fortis Bank Zaventem =C2=B7 Swift GEBABEBB08A =C2=B7 IBAN BE3900138235861=
9
---584337861-1488949865-1184771429=:15632
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
---584337861-1488949865-1184771429=:15632
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584337861-1488949865-1184771429=:15632--
