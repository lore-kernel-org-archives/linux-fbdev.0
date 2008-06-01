From: Denis Oliver Kropp <dok-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [directfb-dev] DirectFB without FBDev
Date: Sun, 01 Jun 2008 13:57:17 +0200
Message-ID: <48428E9D.30808@directfb.org>
References: <483D7344.6030503@directfb.org> <48426C76.5080606@directfb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <48426C76.5080606-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://mail.directfb.org/cgi-bin/mailman/listinfo/directfb-users>,
	<mailto:directfb-users-request-iGvX3keArt1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://mail.directfb.org/pipermail/directfb-users>
List-Post: <mailto:directfb-users-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:directfb-users-request-iGvX3keArt1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <http://mail.directfb.org/cgi-bin/mailman/listinfo/directfb-users>,
	<mailto:directfb-users-request-iGvX3keArt1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Sender: directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org
Errors-To: directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org
To: directfb-dev-iGvX3keArt1g9hUCZPvPmw@public.gmane.org, directfb-users-iGvX3keArt1g9hUCZPvPmw@public.gmane.org
Cc: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

Denis Oliver Kropp wrote:
> I'm partly rewriting the FBDev system module now. Without those
> workarounds, but a different overall structure it should behave
> much better.

New commits:
http://git.directfb.org/?p=core/DirectFB.git;a=commit;h=18552ace2ccfd852fac90016844cd30027b432aa
commit 18552ace2ccfd852fac90016844cd30027b432aa
Author: Denis Oliver Kropp <dok-NwL2HUT4ws72VUFvYR39d//2nO7Rh1Op@public.gmane.org>
Date:   Sun Jun 1 15:03:11 2008 +0200

     [fbdev] The big fix[tm]

     Still not working again is support for virtual resolutions with panning,
     not double/triple buffering which works.

  systems/fbdev/fbdev.c              |  518 +++++++++++++++++++++++++++++-------
  systems/fbdev/fbdev.h              |   14 +-
  systems/fbdev/fbdev_surface_pool.c |   53 +++--
  3 files changed, 467 insertions(+), 118 deletions(-)


-- 
Best regards,
   Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"
