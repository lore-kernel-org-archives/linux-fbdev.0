From: Yauhen Kharuzhy <jekhor@gmail.com>
Subject: jekhor@gmail.com: Metronomefb porting details
Date: Mon, 23 Mar 2009 16:05:55 +0200
Message-ID: <20090323140555.GA30847@jeknote.loshitsa1.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jekhor@gmail.com>) id 1LlknB-0003fl-UG
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Mar 2009 14:06:17 +0000
Received: from mail-ew0-f169.google.com ([209.85.219.169])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Llkn2-0005Fo-Te for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Mar 2009 14:06:17 +0000
Received: by ewy17 with SMTP id 17so1613722ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 23 Mar 2009 07:06:06 -0700 (PDT)
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
To: linux-fbdev-devel@lists.sourceforge.net

Forwarded message from me to Jaya Kumar (I forgot to add linux-fbdev-devel to Cc:).

----- Forwarded message from Yauhen Kharuzhy <jekhor@gmail.com> -----

From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: openinkpot-hackers@googlegroups.com
Subject: Metronomefb porting details

Hi.

I am porting metronomefb to new 5-inch bookreader (HanWong N516) and
have some questions.

1. metronomefb_var.[xy]res and [xy]res_virtual are set to fw/fh
values, which are not equal to real size of panel. Then this values
sending to X server and it make impropely decision about framebuffer
parameters. In my hardware I was able to set xres of LCDC framebuffer to
800 and set fw field of epd_frame_table entry to 800 for resolving
this, but it only masks the problem.

2. According with specifications, Metronome supports 4 bit per pixel,
but in the metronomefb only 3 bpp format is used (metronomefb_var.red = { 4, 3, 0 }).
Can you explain this moment? Is it real colordepth of panels?

3. X server is works, but when I try to load gradient image directly to
/dev/fb1 (file with blocks of bytes from 0x00 to 0x0f), only black
screen is shown. When I load 0xff bytes to it, screen fills by white
color. Can you comment this? 

4. I found that error messages in the load_waveform function caused oops
because info->dev is not initialised at this stage yet.

5. I think that waveform filesize check is completely useless. I have
two waveforms files for N516 and they have different sizes. I don't know
which file is used in the original firmware, but I tried both and they
work.

6. load_waveform() cannot be called more than one times with one
firmware because it changes fields trc and mc in the wfm_hdr structure.
I think that this is bug.

----- End forwarded message -----

-- 
Yauhen Kharuzhy		jekhor _at_ gmail.com
			JID: jek@jabber.ru

A: No
Q: Should I quote below my post?

------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
