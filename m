From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: multiple outputs
Date: Fri, 22 Aug 2008 10:35:04 -0400
Message-ID: <a728f9f90808220735h498e0b37wd7f9f5d84e346041@mail.gmail.com>
References: <376ea3380808212142x390fd4f8we9d6fac6439fe94b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KWXjG-0007Dv-Sa for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Aug 2008 07:35:07 -0700
Received: from nf-out-0910.google.com ([64.233.182.190])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KWXjG-0007Fs-B2
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Aug 2008 07:35:06 -0700
Received: by nf-out-0910.google.com with SMTP id g16so219056nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 22 Aug 2008 07:35:05 -0700 (PDT)
In-Reply-To: <376ea3380808212142x390fd4f8we9d6fac6439fe94b@mail.gmail.com>
Content-Disposition: inline
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
To: Jon Dufresne <jon.dufresne@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, Aug 22, 2008 at 12:42 AM, Jon Dufresne <jon.dufresne@gmail.com> wrote:
> I have a graphics device (intel 945GM) that has multiple outputs (4 in
> this case, although not all can be on at the same time). I want to use
> the graphics device directly through the fb, and not through some
> other layer such as X. When using the fb is it possible to tell the
> graphics device to change outputs through ioctls, or ideally through
> fbset?

The current intelfb driver does not support anything other than the
DAC at the moment anyway.  Work is in progress to support modesetting
in the drm which will allow you to select outputs and crtcs.

Alex

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
