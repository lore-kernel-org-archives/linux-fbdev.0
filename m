From: Alex Deucher <agd5f@yahoo.com>
Subject: Re: [Dri-devel] Rage128 and Radeon patches
Date: Thu, 14 Aug 2003 06:22:40 -0700 (PDT)
Sender: devel-admin@XFree86.Org
Message-ID: <20030814132240.6523.qmail@web11307.mail.yahoo.com>
References: <20030814034338.25567.qmail@web14907.mail.yahoo.com>
Reply-To: devel@xfree86.org
Mime-Version: 1.0
Return-path: <devel-admin@XFree86.Org>
In-Reply-To: <20030814034338.25567.qmail@web14907.mail.yahoo.com>
Errors-To: devel-admin@XFree86.Org
List-Help: <mailto:devel-request@XFree86.Org?subject=help>
List-Post: <mailto:devel@XFree86.Org>
List-Subscribe: <http://XFree86.Org/mailman/listinfo/devel>,
	<mailto:devel-request@XFree86.Org?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://XFree86.Org/mailman/listinfo/devel>,
	<mailto:devel-request@XFree86.Org?subject=unsubscribe>
List-Archive: <http://XFree86.Org/mailman/private/devel/>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>, dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: devel@xfree86.org

--- Jon Smirl <jonsmirl@yahoo.com> wrote:
> Hopefully these is the last versions. They implement:
> 1) add every know PCI ID
> 2) access ROM directly instead of relying on copy in
> low RAM. This allows multiple cards. Required
> MPP_TB_CONFIG fix in driver.

Is this patch necessary for xfree86?  It may address some of the issues
in the email threads I sent out yesterday (ie, problems with multiple
radeon cards and xfree86).  if so would you consider making one?

Alex

> 3) implemented kernel 2.6 module parameters
> 4) Cleaned up error paths and made sure resources are
> released on errors. Both build without compiler
> warnings now. You can ins/rm mod multiple times
> without problem. Just don't do it from a window in
> your X server.
> 5) Driver marks both primary and secondary devices as
> being in use.
> 


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
