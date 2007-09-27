From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [Cbe-oss-dev] [patch 0/8] PS3 AV Settings
 Driver patches for 2.6.24
Date: Thu, 27 Sep 2007 10:23:09 -0700
Message-ID: <46FBE6FD.3030605@am.sony.com>
References: <20070926163308.772580000@pademelon.sonytel.be>
	<1190860285.6502.6.camel@concordia>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iax5B-0007yF-CB for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Sep 2007 10:23:27 -0700
Received: from outbound-blu.frontbridge.com ([65.55.251.16]
	helo=outbound7-blu-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Iax58-0008C1-KY
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Sep 2007 10:23:24 -0700
In-Reply-To: <1190860285.6502.6.camel@concordia>
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
To: michael@ellerman.id.au
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, "Antonino A. Daplas" <adaplas@gmail.com>

Michael Ellerman wrote:
> On Wed, 2007-09-26 at 18:33 +0200, Geert Uytterhoeven wrote:
>> 	Hi,
>> 
>> Here are some new patches for the PS3 AV Settings Driver (ps3av), which is
>> used in close collaboration with the PS3 Virtual Frame Buffer Device Driver
>> (ps3fb):
>>   [1] ps3av: eliminate unneeded temporary variables
>>   [2] ps3av: eliminate PS3AV_DEBUG
>>   [3] ps3av: use PS3 video mode ids in autodetect code
>>   [4] ps3av: treat DVI-D like HDMI in autodetect
>>   [5] ps3av: add autodetection for VESA modes
>>   [6] ps3av: add quirk database for broken monitors
>>   [7] ps3av: remove unused ps3av_set_mode()
>>   [8] ps3av: don't distinguish between `boot' and `non-boot' autodetection
>> 
>> Please review, and queue for 2.6.24 if they're ok. Thanks!
>> 
>> Question: As several DVI-D displays advertise they support 1080i modes while
>> they actually don't (cfr. the quirk database), perhaps I should drop 1080i
>> modes completely from the ps3av_preferred_modes[] table? Usually 720p looks
>> better than 1080i anyway.  What do you think?
> 
> Definitely. If the autodetection fails Linux is basically unusable on
> PS3 unless you hack the kernel sources and build your own kboot and
> otheros.bld - not entirely trivial for novice users. So it's pretty
> important that it works 100%.

It is not that bad.  If a bootloader is configued to use autodetection
so that it is shown at best video mode, then it should have advertised
key sequences to default to known video modes, with at least a 480p 'safe'
mode.

Second stage kerenls can be booted with a videomode appended on the
command line, and all kboot.conf's should have a 480p 'safe' mode
entry.

-Geoff


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
