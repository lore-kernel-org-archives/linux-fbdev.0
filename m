From: Javier Marcet <javier-ml-gmane@marcet.info>
Subject: Re: [PATCH][FBCON]: Mode Switch in fbcon_blank()
Date: Fri, 02 Jul 2004 12:25:31 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <cc3d6r$d5v$1@sea.gmane.org>
References: <200406301047.57423.adaplas@hotpop.com> <1088564019.1922.12.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7Bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgLSz-00022J-2Z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 03:40:25 -0700
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BgLSy-0004eJ-LN
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 03:40:25 -0700
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1BgLSw-0006rO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 02 Jul 2004 12:40:22 +0200
Received: from www.marcet.info ([213.60.130.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 02 Jul 2004 12:40:22 +0200
Received: from javier-ml-gmane by www.marcet.info with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 02 Jul 2004 12:40:22 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

Benjamin Herrenschmidt wrote:

>> As we've discussed in another thread, below is a diff that will do a
>> set_par() as late as possible when there is KD_TEXT<->KD_GRAPHICS
>> switch.  The set_par() will be forced in fbcon_resize() instead.

>> Not sure if this has repercussions with the other drivers, but this patch
>> fixed the X nv driver hanging when switching to the console. (I believe
>> the crash is actually caused by an early set_par() -- while in
>> fbcon_blank. Removing the set_par in fbcon_blank fixed the hang but
>> caused cursor sprite and display corruption).

> Well... I don't know. It seem to work, so it's probably an acceptable
> workaround, but I'd like to find out what's wrong with doing it in blank
> precisely (that is what is the bug in XFree or in the kernel VT), since
> it's shared by many X drivers, I don't suppose it's a bug in them.

This was included in 2.6.7-mm5 -that's how I noticed it- and I had to
revert it.

I use radeonfb and when switching from X to console my two monitors will
go out of sync. The VT is actually there since I can type on it, but I
can't see anything on neither of my two monitors :(


-- 

Homer:  Hey, Burns!  Eat my shorts!

Burns:  Who the Sam Hill was that?

                   One Fish, Two Fish, Blowfish, Blue Fish

Javier Marcet <javier@marcet.info>




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
