From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [RFC] Does fbdev need a cursor API for userland?
Date: Mon, 18 Oct 2004 05:51:11 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410180551.11105.adaplas@hotpop.com>
References: <200410172347.15516.adaplas@hotpop.com> <4172A952.4080607@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJIpy-0002Do-Fp
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 14:45:10 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CJIpx-0002HX-MT
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 14:45:10 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 75DA79096F9
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 17 Oct 2004 21:44:56 +0000 (UTC)
In-Reply-To: <4172A952.4080607@comcast.net>
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
To: linux-fbdev-devel@lists.sourceforge.net, Zachary Smith <plinius@comcast.net>

On Monday 18 October 2004 01:18, Zachary Smith wrote:
> Antonino A. Daplas wrote:
> > IMO, I believe that the cursor ioctl should just be removed :-)
>
> Well I don't need a cursor from userland, but I do need a way to
> manage the hardware cursor (sprite) if it exists from within
> the kernel.
>

I'm not sure I understand.

What I'm proposing is removal of kernel support of the cursor for userland
fbdev applications. The fbcon->fbdev cursor interface will still exist.  The
sprite, whether by hardware or software, is managed by fbcon.  The cursor
characteristics, albeit limited, are changed via the vt->fbcon->fbdev
pathway (see Documentation/ VGA-softcursor.txt).

Should the console cursor have other modifiable characteristics besides
changing the shape (underline, block, half-block, etc), and changing the
color?

Tony




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
