From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Radeon support (was Re: (no subject))
Date: Wed, 7 Aug 2002 21:19:39 -0400 (EDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33L2.0208072117190.4716-100000@memory.visualtech.com>
References: <Pine.LNX.4.33L2.0208061328320.14175-100000@memory.visualtech.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from memory.visualtech.com ([208.16.19.49])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cbxY-0004EN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 Aug 2002 18:19:28 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by memory.visualtech.com (Postfix) with ESMTP id E1F904CFD
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  7 Aug 2002 21:19:39 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.33L2.0208061328320.14175-100000@memory.visualtech.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net


Me again,

=09So I think I might have a better idea of what's going on... I did
some testing with the Radeon framebuffer tonight, and can only seem to get
it to work with just two modes: 1024x768@70 and 640x480@60.  I've tried a
number of others, which worked with the DVI output of my 7500, but don't
seem to work with the VGA port of the card.

=09Any ideas?

Adam

On Tue, 6 Aug 2002, Adam K Kirchhoff wrote:

>
> Ani and others :-)
>
> =09I was hoping you could lend me some insight :-)  I'm trying to do
> some work with DirectFB, and I'm now running into a slight problem
> concerning getting output on the VGA port.
>
> =09I've e-mailed the directfb-dev mailing list about it and had some
> interesting conversations, but the end result was basically: "You should
> check with Ani Joshi about that, and maybe ask on the linux-fbdev-devel
> mailing list".
>
> =09So now I'm asking here :-)  Below this I'm including the
> description of the problem I'm seeing that I sent to the directfb-dev
> mailing list.
>
> =09Can anyone help me out?  Thanks :-)
>
> Adam
>
> ---------- Forwarded message ----------
> Date: Tue, 6 Aug 2002 12:51:24 -0400 (EDT)
> From: Adam K Kirchhoff <adamk@voicenet.com>
> To: "[iso-8859-1] Ville Syrj=E4l=E4" <syrjala@sci.fi>
> Cc: directfb-devel <directfb-dev@directfb.org>
> Subject: Re: [directfb-dev] Re: Radeon support...
>
>
> > I'm getting really confused as to what's going on... What exactly happe=
ns
> > when you run a DirectFB application?
>
> It took me a while to figure it out what I know so far, and I'm still not
> 100% sure what's going on...
>
> If I run *any* DirectFB application, the screen blanks.  The system
> doesn't lock.  I can ssh in and see the application listed in the process
> table.  For example, running df_fire, the screen blanks and, after a few
> seconds, the monitor goes to sleep (as if it's no longer getting a
> signal)...  Hitting the 'esc' key brings back the vt, just as usual when
> runnin the application.
>
> Running dfbsee produces similar results.  However, with any video that I
> play, I can hear the audio stream :-)  I just can't see anything...
>
> Now, when I first experienced this, I posted about it on either
> directfb-dev or directfb-user.  A short while later, I figured out a
> workaround :-)
>
> Instead of booting with my CRT plugged into the VGA port, I used a
> DVI-to-VGA adapter (that came with my Radeon 7500), and plugged the
> monitor into the DVI-A port.  Lo' and behold, DirectFB applications were
> now showing up :-)
>
> Since then I've done some video card swapping and now have a "Powered By
> ATI" Radeon 8500 LE.  This card has both a VGA port and a DVI-D port, but
> no adapter.  The old adapter doesn't work for this card because it's
> designed for DVI-A as compared to DVI-D.
>
> I've encountered similar problems elsewhere, too.  For example, a hacked
> radeon 7500 driver for BeOS would only display on the DVI port, even if
> the computer booted up fine with a monitor on the VGA port.
>
> Of course, I just don't know why this is the case :-)
>
> I've been poking around on-line looking for a DVI-D to VGA adapter, but
> very few of the shops that sell them on-line clarify if it's DVI-A or
> DVI-D :-)
>
> Adam
>
>
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
