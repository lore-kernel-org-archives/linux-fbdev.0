From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] Does fbdev need a cursor API for userland?
Date: Sun, 17 Oct 2004 18:25:54 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <9e4733910410171525543c1992@mail.gmail.com>
References: <200410172347.15516.adaplas@hotpop.com>
	 <4172A952.4080607@comcast.net> <200410180551.11105.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJJTQ-0000nU-6Z
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 15:25:56 -0700
Received: from rproxy.gmail.com ([64.233.170.207] helo=mproxy.gmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CJJTP-0002JK-El
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 15:25:56 -0700
Received: by mproxy.gmail.com with SMTP id 79so121421rnk
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 17 Oct 2004 15:25:54 -0700 (PDT)
In-Reply-To: <200410180551.11105.adaplas@hotpop.com>
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

On Sun, 17 Oct 2004 23:47:15 +0800, Antonino A. Daplas
<adaplas@hotpop.com> wrote:

> IMO, I believe that the cursor ioctl should just be removed :-)

The merged fbdev/DRM needs hardware cursor support in fbdev but it
doesn't need the fbdev cursor IOCTL. Moving cursor support to fbcon
won't work either. Implementing cursor support in merged fbdev/DRM
probably means a modified API since we have to deal with multiple
heads.

Are there cards still out there with no hardware cursor support?
How many apps use the user space fbdev interface?

Also, a some point I would like to revisit the fbcon/fbdev interface
and reduce the number of fbdev variables fbcon can access but doesn't
use. fbcon shouldn't have direct access to the fb_info struct, there
should be more of an interface there.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
