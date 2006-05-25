From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fbcon: Fix scrollback with logo issue
 immediately after boot
Date: Thu, 25 May 2006 08:35:12 +0800
Message-ID: <4474FBC0.5050806@gmail.com>
References: <20060524194128.GA2680@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fj3p6-00051l-UI
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 May 2006 17:35:32 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fj3p5-0008QI-O7
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 May 2006 17:35:33 -0700
Received: by py-out-1112.google.com with SMTP id b29so2049461pya
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 May 2006 17:35:30 -0700 (PDT)
In-Reply-To: <20060524194128.GA2680@cosmic.amd.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
Cc: david.hollister@amd.com, jordan.crouse@amd.com

Jordan Crouse wrote:
> Greeting folks -
> 
> Sending on a patch against latest git that attempts to fix an issue with
> the scrollback buffer in the fbcon immediately after boot.    As always,
> comments welcome.

Looks sane.  Does this patch fix the problem mentioned here?

http://marc.theaimsgroup.com/?l=linux-kernel&m=114821885109864&w=2

Tony




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
