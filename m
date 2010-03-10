From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video 
	mode
Date: Wed, 10 Mar 2010 15:06:08 -0500
Message-ID: <a728f9f91003101206ye50e82dt1ff96b402d1e36ae@mail.gmail.com>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
	<a5d587fb1003010118r1b586990ja4144441143bb4be@mail.gmail.com>
	<21d7e9971003022102v232c099r441b0bd843b30313@mail.gmail.com>
	<alpine.LFD.2.00.1003101738420.4419@casper.infradead.org>
	<a728f9f91003101005v374b2cacpb307542e65d22d6f@mail.gmail.com>
	<a728f9f91003101010m4fc94398l14c8625d7442100a@mail.gmail.com>
	<alpine.LFD.2.00.1003101819290.4419@casper.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <dri-devel-bounces@lists.sourceforge.net>
In-Reply-To: <alpine.LFD.2.00.1003101819290.4419@casper.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=dri-devel>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: dri-devel-bounces@lists.sourceforge.net
To: James Simmons <jsimmons@infradead.org>
Cc: Old FrameBuffer List <linux-fbdev-devel@lists.sourceforge.net>, DRI development list <dri-devel@lists.sourceforge.net>, Michal Suchanek <hramrach@centrum.cz>, Paulius Zaleckas <paulius.zaleckas@gmail.com>

On Wed, Mar 10, 2010 at 1:47 PM, James Simmons <jsimmons@infradead.org> wro=
te:
>
>> >> Yuck. See my other post about what fbdev really means in its historic=
al
>> >> context. The struct fb_info really maps better to drm_crtc than to
>> >> drm_framebuffer. In fact take the case of the matrox fbdev driver. It
>> >> creates two framebuffer devices even tho it used one static framebuff=
er.
>> >> What the driver does is splits the framebuffer in two and assigned ea=
ch
>> >> part to a CRTC.
>> >
>> > The only problem with that is that it eats a lot of memory for the
>> > console which limits X when it starts. On cards with limited vram ,
>> > you might not have enough memory left for any meaningful acceleration
>> > when X starts.
>>
>> It would be nice to find a way to reclaim the console memory for X,
>> but I'm not sure that can be done and still provide a good way to
>> provide oops support.
>
> =A0 =A0 =A0 =A0Ah, the power of flags. We had the same issue with user re=
questing a mode
> change or fbcon asking for a different mode. We handled it with the flag
> FBINFO_MISC_USEREVENT. Since you are using KMS as the backend for fbcon y=
ou will
> have to deal also with the ability to change the resolution with tools li=
ke stty.
> I can easily see how to do this plus give you more memory like you want :=
-)
> =A0 =A0 =A0 =A0For the oops are you talking about printing oops to the sc=
reen
> while X is running ? Otherwise if you experience a oops and go back to
> console mode you should be able to view it. The console text buffer is
> independent of the graphics card memory system.
>

Right now we keep the console buffer pinned in vram and we switch to
it when there is an oops or when you switch VTs.

Alex

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--
