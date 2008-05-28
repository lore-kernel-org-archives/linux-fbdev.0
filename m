From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: [directfb-users] DirectFB without FBDev
Date: Wed, 28 May 2008 15:33:06 -0400
Message-ID: <a728f9f90805281233h4ca3ef3dnf6aeec8aaf64f39f@mail.gmail.com>
References: <483D7344.6030503@directfb.org>
	<Pine.LNX.4.64.0805281901300.15083@anakin>
	<483D9453.1080700@directfb.org> <483D9C30.8010301@acdstar.com>
	<483D9F4E.4000707@directfb.org>
	<a728f9f90805281124y53df86e7n7ae1918ac97907fc@mail.gmail.com>
	<483DAB14.3020300@directfb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1ROX-0004eN-7r for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 12:33:09 -0700
Received: from rv-out-0708.google.com ([209.85.198.247])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K1ROU-0001Bn-Ud
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 12:33:09 -0700
Received: by rv-out-0708.google.com with SMTP id f25so2924969rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 28 May 2008 12:33:06 -0700 (PDT)
In-Reply-To: <483DAB14.3020300@directfb.org>
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
To: Denis Oliver Kropp <dok@directfb.org>
Cc: directfb-users@directfb.org, "Brian G. Rhodes" <bgr@acdstar.com>, linux-fbdev-devel@lists.sourceforge.net, directfb-dev@directfb.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Wed, May 28, 2008 at 2:57 PM, Denis Oliver Kropp <dok@directfb.org> wrote:
> Alex Deucher wrote:
>>
>> As you may or may not be aware, the drm is slowly getting modesetting
>> support including support for multiple crtcs and outputs and better
>> memory management.  Development is currently focusing on intel, but
>> AMD support will follow soon.  It even provides a legacy fbdev compat
>> layer.
>>
>> http://cgit.freedesktop.org/mesa/drm/log/?h=modesetting-101
>
> It looks interesting and we should consider using libdrm in DirectFB,
> but I could not find anything about display layers and it's already quite
> big and kernel side drivers have this GPL issue etc...

In theory the code will be X11 licensed since it's coming from Xorg
and shared with BSD, but I guess it's kind of a grey area.

Alex

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
