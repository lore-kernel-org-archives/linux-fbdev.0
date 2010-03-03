From: Dave Airlie <airlied@gmail.com>
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video 
	mode
Date: Wed, 3 Mar 2010 19:23:37 +1000
Message-ID: <21d7e9971003030123q2e5d073dj68a81d612e26dc94@mail.gmail.com>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
	<a5d587fb1003010118r1b586990ja4144441143bb4be@mail.gmail.com>
	<21d7e9971003022102v232c099r441b0bd843b30313@mail.gmail.com>
	<a5d587fb1003030023l355eab4dtb9f4cd62058dea3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.sourceforge.net>
In-Reply-To: <a5d587fb1003030023l355eab4dtb9f4cd62058dea3e@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=dri-devel>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: dri-devel-bounces@lists.sourceforge.net
To: Michal Suchanek <hramrach@centrum.cz>
Cc: dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, Paulius Zaleckas <paulius.zaleckas@gmail.com>

>>
>>
>> I've only really got two answer for this:
>>
>> (a) hook up another /dev/dri/card_fb device and use the current KMS
>> ioctls to control the framebuffer, have the drm callback into fbdev/fbcon
>> to mention resizes etc. Or add one or two info gathering ioctls and
>> allow use of the /dev/dri/control device to control stuff.
>>
>
> What about writing a drmfbset or something and have fbset call it when
> it detects a drm framebuffer and warn that it does not support drm
> framebuffers fully?
>

My main problem with calling the drm underneath the fbdev is it
seems like a layering violation. Then again some of code in the kernel
is also contributing to this violation. I'd really like to make fbdev more
like an in-kernel version of what X driver have to do, and leave all the
initial modepicking etc to the fbdev interface layer.

If we take  the layering as
fbcon -> fbdev -> kms -> hw

I feel calling ioctls on the KMS layer from userspace to do stuff for
fbcon or fbdev
is wrong, and we should rather expose a more intelligent set of ioctls via the
fbdev device node. This points at quite a bit of typing.

So we'd need to add a bunch of KMS fb specifc ioctl like some of the other fbdev
drivers do, and then a new fbset could tkae advantage of these. I'm not sure
how much different to the current kms interface or how powerful we really need
to make tihs interface though, and I feel kinda bad implementing it without
some idea what users would want from it.

Dave.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--
