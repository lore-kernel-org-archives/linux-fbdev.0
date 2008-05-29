From: Sven Luther <sven-XkLrfMvk983aVgXGlvhGPA@public.gmane.org>
Subject: Re: [directfb-dev] [Linux-fbdev-devel] DirectFB
	without FBDev
Date: Thu, 29 May 2008 18:54:52 +0200
Message-ID: <20080529165452.GA7708@powerlinux.fr>
References: <483D7344.6030503@directfb.org>
	<Pine.LNX.4.64.0805281901300.15083@anakin>
	<483D9453.1080700@directfb.org> <483D9C30.8010301@acdstar.com>
	<483D9F4E.4000707@directfb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <483D9F4E.4000707-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
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
To: Denis Oliver Kropp <dok-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
Cc: directfb-users-iGvX3keArt1g9hUCZPvPmw@public.gmane.org, "Brian G. Rhodes" <bgr-3mWahjwryh5BDgjK7y7TUQ@public.gmane.org>, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, directfb-dev-iGvX3keArt1g9hUCZPvPmw@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

On Wed, May 28, 2008 at 08:07:10PM +0200, Denis Oliver Kropp wrote:
> Brian G. Rhodes wrote:
> I don't think a new kernel graphics interface should be added, instead using
> UIO to access MMIO, DMA and IRQs would be enough and implement most of the
> graphics driver in user space. Downside is to loose the kernel console which
> you usually don't need on an embedded device...
> 
> For acceleration and DMA/IRQ based programming, I still need to check if a
> user space approach would be enough. So far I always handled IRQs in kernel
> space for timing/performance reasons...

Euh, well, i think the X / OpenGL approach showed us that to do DMA/IRQ,
you need a kernel module, and what X/OpenGL is the DRI thingy.

Would it make sense for directfb to re-use this selfsame infrasturcture,
which already exists in the kernel, and is used by X, so kind of
guaranteed to be available for many graphic cards ? 

But maybe it is too complex or something ? 

Friendly,

Sven Luther
