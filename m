From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: 2.6.7 still garbage upon start
Date: Fri, 18 Jun 2004 18:04:58 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406181804.05653.adaplas@hotpop.com>
References: <40D21E31.5070904@winischhofer.net> <200406180945.06335.adaplas@hotpop.com> <40D29FCD.7020602@winischhofer.net>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbGFB-00087L-RG
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 03:05:09 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbGF9-00010f-VB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 03:05:08 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id ECD105D1626
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Jun 2004 09:26:30 +0000 (UTC)
In-Reply-To: <40D29FCD.7020602@winischhofer.net>
Content-Disposition: inline
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Friday 18 June 2004 15:54, Thomas Winischhofer wrote:
>
> > (I have code I'm planning to send for RFC that will notify the
> > low-level driver if switching from KD_GRAPHICS->KD_TEXT and vice
> > versa or if multiple drivers are mapped to different consoles.
> > However, it seems BenH already has code for this so I'm holding the
> > submission.  I just can't find BenH's changes in 2.6.7 or -mm.  Hey
> > Ben, where is it?)
>
> Perhaps I am being naive, but I don't understand what the problem can
> be. X restores the display mode before initiating the VT change. And a
> VT change should restore the previous screen contents.
>

True, most of the time, there's no problem switching to X as X does a good job 
of restoring its own state.  It's in the other direction, switching from X to 
VC, that fbcon must correctly determine if there is a need to restore the 
hardware state.

With the separation of fbcon and fbdev in 2.6.x, it is now fbcon which decides 
when to do a set_par or not.  Currently, a set_par (via set_var) is only 
called if the current var and the new var is not the same.  So, when you 
switch from  X's VC to the console, fbcon assumes  there was no state change 
(mistakenly, of course, from the POV of fbcon). This is because the current 
var (info->var) and the new_var (created in fbcon_switch->fbcon_resize) is 
the same. As you can see, this leaves fbdev in an undefined state.

So, one solution is to have fbcon detect a switch between consoles in which 
the old console is in graphics mode and the new console will be in text mode.  

Tony  
 




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
