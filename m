From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: fbcon=map:... broke with 2.6.7 -> 2.6.9-rc3 transition
Date: Wed, 6 Oct 2004 19:04:10 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410061904.10630.adaplas@hotpop.com>
References: <20041006100310.GA14889@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CF9an-0002KS-Ul
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 06 Oct 2004 04:04:21 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CF9am-0001aF-Bw
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 06 Oct 2004 04:04:21 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 830668BCB28
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  6 Oct 2004 11:04:06 +0000 (UTC)
In-Reply-To: <20041006100310.GA14889@sci.fi>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net, Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>

On Wednesday 06 October 2004 18:03, Ville Syrj=E4l=E4 wrote:
> I just upgraded from 2.6.7 to 2.6.9-rc3 and the fbcon=3Dmap:... option
> stopped working.
>
> My system has two matrox cards with /dev/fb1 being the head I want to use.
> So I boot with fbcon=3Dmap:111111. With 2.6.9-rc3 all I could see was
> some garbage and I had to log in via network to run con2fb manually. I
> don't have a monitor attached to the other card so I'm not sure if the
> output went there.
>
> I seem to recall some patches from Tony regarding fbcon options. Were
> those applied to 2.6.9-rc3?

No, it's still in the mm tree.  It won't get into mainline until 2.6.10, I =
think.
Ask Andrew.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
