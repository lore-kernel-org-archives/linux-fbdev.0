From: Denis Oliver Kropp <dok-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Linux-fbdev-devel]  DirectFB without FBDev
Date: Wed, 28 May 2008 20:57:24 +0200
Message-ID: <483DAB14.3020300@directfb.org>
References: <483D7344.6030503@directfb.org>	
	<Pine.LNX.4.64.0805281901300.15083@anakin>	
	<483D9453.1080700@directfb.org> <483D9C30.8010301@acdstar.com>	
	<483D9F4E.4000707@directfb.org>
	<a728f9f90805281124y53df86e7n7ae1918ac97907fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <a728f9f90805281124y53df86e7n7ae1918ac97907fc-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: directfb-users-iGvX3keArt1g9hUCZPvPmw@public.gmane.org, "Brian G. Rhodes" <bgr-3mWahjwryh5BDgjK7y7TUQ@public.gmane.org>, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, directfb-dev-iGvX3keArt1g9hUCZPvPmw@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Alex Deucher wrote:
> As you may or may not be aware, the drm is slowly getting modesetting
> support including support for multiple crtcs and outputs and better
> memory management.  Development is currently focusing on intel, but
> AMD support will follow soon.  It even provides a legacy fbdev compat
> layer.
> 
> http://cgit.freedesktop.org/mesa/drm/log/?h=modesetting-101

It looks interesting and we should consider using libdrm in DirectFB,
but I could not find anything about display layers and it's already quite
big and kernel side drivers have this GPL issue etc...

-- 
Best regards,
   Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"
