From: Richard Smith <rsmith@bitworks.com>
Subject: Re: Re: Current discussion about the future of
 free software graphics
Date: Wed, 12 May 2004 15:45:11 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40A28CD7.6030105@bitworks.com>
References: <Pine.LNX.4.44.0405121854590.30585-100000@phoenix.infradead.org>
Reply-To: rsmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BO0c7-0005kd-B6
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 May 2004 13:46:03 -0700
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BO0c4-0006cx-Is
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 May 2004 13:46:03 -0700
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 May 2004 15:44:24 -0500
In-Reply-To: <Pine.LNX.4.44.0405121854590.30585-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Somehow this dosen't appear to have made it the first time.  Apologies 
if 2 of these show up.


James Simmons wrote:

> That app must be pretty big if it runs on non intel platforms. You nedd to 
> translate the x86 BIOS code to native assembly before you run it.

Or you emulate thier functionality.. but perhaps thats what you are
saying.  Thats what X does.  LinuxBIOS has pulled the x86emu out into a
standalone userspace app that we use to try and get video cards up
across a serial console.  Currently that app is 400k (dynamic linked)

The plan though is to include that emulation ability into LinuxBIOS and
400k is way to large.  The authors feel though that it can be done.  I
think the core pieces aren't really that big.

It dosen't seem to work with my ATI bios though which is why I was
interested in another implementation.  Word is that the current
LinuxBIOS implementation has issues with int10 replacement and then
calling back into itself.

>>Jon Smirl wrote:
>>
>>
>>>licenses). I've already built a very messy prototype by moving the existing
>>>fbdev code to user space and it works just fine. I also called another little
>>>app which executed the VBIOS and reset secondary cards at boot via hotplug.
>>
>>Is that app available somewhere?  I'm trying to get an ATI Rage Mobility 
>>  M1 chip up under LinuxBIOS and such and app would be useful for me.




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
