From: Michal Suchanek <hramrach@centrum.cz>
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video 
	mode
Date: Mon, 1 Mar 2010 10:18:03 +0100
Message-ID: <a5d587fb1003010118r1b586990ja4144441143bb4be@mail.gmail.com>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com> 
	<21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.sourceforge.net>
In-Reply-To: <21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=dri-devel>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: dri-devel-bounces@lists.sourceforge.net
To: Dave Airlie <airlied@gmail.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, Paulius Zaleckas <paulius.zaleckas@gmail.com>

On 21 November 2009 05:27, Dave Airlie <airlied@gmail.com> wrote:

> At the moment the problem with fbset is what to do with it in the
> dual head case. Currently we create an fb console that is lowest
> common size of the two heads and set native modes on both,

Does that mean that fbset is supposed to work (set resolution) on drmfb?

>
> Now if a user runs fbset, I'm not sure what the right answer is,
> a) pick a head in advance via sysfs maybe and set it on that.
> b) try and set the mode on both heads cloned (what to do if
> there is no common mode is another issue).
>

I would say it's time to support multihead with fbset properly.

That is people would need new fbset which sees both (all) heads, and
fbset can then choose the head itself (and people can make it do
something different when they don't like the default). It should also
support setting up rotation on each head.

For old fbset setting something visible is probably good enough.

Schemes which would make a multihead setup look like a single screen
get complicated quite easily. Perhaps an option to turn off some
outputs so that the native resolution of one output is used (instead
of clone) would work.

Thanks

Michal

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--
