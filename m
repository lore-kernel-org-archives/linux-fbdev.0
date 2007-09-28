From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [Cbe-oss-dev] [patch 0/8] PS3 AV Settings
 Driver patches for 2.6.24
Date: Fri, 28 Sep 2007 12:29:08 -0700
Message-ID: <46FD5604.3060104@am.sony.com>
References: <20070926163308.772580000@pademelon.sonytel.be>	
	<1190860285.6502.6.camel@concordia> <46FBE6FD.3030605@am.sony.com>
	<1190968833.15970.3.camel@concordia>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbLWd-0007og-Mm for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 12:29:23 -0700
Received: from outbound-dub.frontbridge.com ([213.199.154.16]
	helo=outbound1-dub-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IbLWa-0002Hk-Kg
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 12:29:23 -0700
In-Reply-To: <1190968833.15970.3.camel@concordia>
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
> On Thu, 2007-09-27 at 10:23 -0700, Geoff Levand wrote:
>> Michael Ellerman wrote:
>> > On Wed, 2007-09-26 at 18:33 +0200, Geert Uytterhoeven wrote:
>> >> Question: As several DVI-D displays advertise they support 1080i modes while
>> >> they actually don't (cfr. the quirk database), perhaps I should drop 1080i
>> >> modes completely from the ps3av_preferred_modes[] table? Usually 720p looks
>> >> better than 1080i anyway.  What do you think?
>> > 
>> > Definitely. If the autodetection fails Linux is basically unusable on
>> > PS3 unless you hack the kernel sources and build your own kboot and
>> > otheros.bld - not entirely trivial for novice users. So it's pretty
>> > important that it works 100%.
>> 
>> It is not that bad.  If a bootloader is configued to use autodetection
>> so that it is shown at best video mode, then it should have advertised
>> key sequences to default to known video modes, with at least a 480p 'safe'
>> mode.
> 
> Oh OK, that is a good idea. What's the "safe mode" key sequence for the
> otheros.bld you provide on kernel.org?


I don't maintain that, and have no idea how it sets its video mode.  Did you
have trouble with it?  I know in the past it used a fixed 480p mode. 


-Geoff



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
