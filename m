From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: CVS cleanup
Date: Mon, 18 Oct 2004 05:57:36 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410180557.36567.adaplas@hotpop.com>
References: <4172AC3D.37DF426F@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJIw2-0003Ar-77
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 14:51:26 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CJIw1-00032j-Pe
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 14:51:26 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id EFA3E909168
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 17 Oct 2004 21:51:12 +0000 (UTC)
In-Reply-To: <4172AC3D.37DF426F@orpatec.ch>
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
To: linux-fbdev-devel@lists.sourceforge.net, Otto Wyss <otto.wyss@orpatec.ch>
Cc: Sylvain Meyer <sylvain.meyer@ifrance.com>

On Monday 18 October 2004 01:30, Otto Wyss wrote:
> I'm considering to put all code in the CVS into the FBdev directory so
> it can easily be retrieved. The following directory exists:
>
> - atyfb: Seems to be rather old and probably can be removed, otherwise
> I'll move it into "FBdev/drivers/atyfb/".
>
> - fbtest: Seems to be actual => I'll move it into "FBdev/fbtest"
>
> - fbutils: I don't know => I'll move it into "FBdev/fbutils"
>

Why not lump them in a common directory, ie

FBDev/utilities/fbtest, FBDev/utilities/fbutils, etc.

There are requests from other developers who might want to have their own
utilities placed in the linux-fbdev site, ie a tvset utility for the soon to
be ported intelfb. I'm CC'ing the author.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
