From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.27 1/2] fbdev: add E-Ink
	Broadsheet controller support
Date: Tue, 23 Dec 2008 23:22:55 -0500
Message-ID: <45a44e480812232022n576b009tf0a97ac1561b729f@mail.gmail.com>
References: <12298571743158-git-send-email-jayakumar.lkml@gmail.com>
	<Pine.LNX.4.64.0812231351360.17497@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LFLGw-0005a0-2D
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Dec 2008 04:23:02 +0000
Received: from mail-ew0-f21.google.com ([209.85.219.21])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LFLGr-00069N-IK for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Dec 2008 04:23:00 +0000
Received: by ewy14 with SMTP id 14so3296995ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 23 Dec 2008 20:22:56 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0812231351360.17497@anakin>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, Dec 23, 2008 at 7:52 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sun, 21 Dec 2008, Jaya Kumar wrote:
>> --- /dev/null
>> +++ b/drivers/video/broadsheetfb.c
>
>> +static struct fb_var_screeninfo broadsheetfb_var __devinitdata = {
>> +     .xres           = DPY_W,
>> +     .yres           = DPY_H,
>> +     .xres_virtual   = DPY_W,
>> +     .yres_virtual   = DPY_H,
>> +     .bits_per_pixel = 8,
>> +     .grayscale      = 1,
>> +     .nonstd         = 1,
>
> Why do you set .nonstd?
>
> #define FB_NONSTD_HAM           1       /* Hold-And-Modify (HAM)        */
>

Good point, shouldn't be set. Will take it out of broadsheetfb and
also the other e-ink drivers that set it.

Thanks,
jaya

------------------------------------------------------------------------------
