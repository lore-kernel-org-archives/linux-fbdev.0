From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video 
	mode
Date: Thu, 11 Mar 2010 10:12:52 -0500
Message-ID: <a728f9f91003110712l407ed04dl28b86ef77a427218@mail.gmail.com>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
	<a5d587fb1003010118r1b586990ja4144441143bb4be@mail.gmail.com>
	<21d7e9971003022102v232c099r441b0bd843b30313@mail.gmail.com>
	<alpine.LFD.2.00.1003101738420.4419@casper.infradead.org>
	<a728f9f91003101005v374b2cacpb307542e65d22d6f@mail.gmail.com>
	<a728f9f91003101010m4fc94398l14c8625d7442100a@mail.gmail.com>
	<1268302426.7444.117.camel@thor.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <dri-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1268302426.7444.117.camel@thor.local>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=dri-devel>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: dri-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net, Paulius Zaleckas <paulius.zaleckas@gmail.com>, Michal Suchanek <hramrach@centrum.cz>

2010/3/11 Michel D=E4nzer <michel@daenzer.net>:
> On Wed, 2010-03-10 at 13:10 -0500, Alex Deucher wrote:
>> On Wed, Mar 10, 2010 at 1:05 PM, Alex Deucher <alexdeucher@gmail.com> wr=
ote:
>> > On Wed, Mar 10, 2010 at 12:42 PM, James Simmons <jsimmons@infradead.or=
g> wrote:
>> >>
>> >> See my other post about what fbdev really means in its historical
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
> What do you think the average user will care about more?
>
> =A0 =A0 =A0* Seeing kernel oops/panic output about once in a lifetime.
> =A0 =A0 =A0* Being able to start/use X in the first place and enabling it=
 to
> =A0 =A0 =A0 =A0use all of VRAM.
>
> Personally, I've never even seen any kernel oops/panic output despite
> numerous opportunities for that in the couple of months I've been using
> KMS. But I have spent considerable time and effort trying to get rid of
> the pinned fbcon BO. If the oops/panic output is the only thing
> preventing that, maybe that should only be enabled via some module
> option for developers.

I'm all for it!

Alex

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--
