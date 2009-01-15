From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.28 1/2] fbdev: add ability to set
	damage
Date: Thu, 15 Jan 2009 04:53:30 -0500
Message-ID: <45a44e480901150153ta1fbe5fk5480dc5630cf1d6b@mail.gmail.com>
References: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
	<1232011502.900.107.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LNOuw-0003Su-FR
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Jan 2009 09:53:38 +0000
Received: from wf-out-1314.google.com ([209.85.200.168])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LNOur-0004QY-D6 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Jan 2009 09:53:38 +0000
Received: by wf-out-1314.google.com with SMTP id 27so1178329wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 15 Jan 2009 01:53:30 -0800 (PST)
In-Reply-To: <1232011502.900.107.camel@tubuntu>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: tomi.valkeinen@nokia.com
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Magnus Damm <magnus.damm@gmail.com>, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Thu, Jan 15, 2009 at 4:25 AM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Thu, 2009-01-15 at 08:06 +0800, ext Jaya Kumar wrote:
>> Hi Geert, Krzysztof, Magnus, fbdev friends,
>>
>> I would like to propose this idea about allowing userspace to provide damage
>> information to drivers. This is just a first pass implementation. Please let
>> me know your thoughts.
>
> omapfb does actually something similar with a custom IOCTL,
> OMAPFB_UPDATE_WINDOW. If other fbs need similar functionality, then this
> sounds good to me.
>
> However, those kallocs give me some shivers. I don't know how fast
> kallocs are, so perhaps I'm worrying about nothing. But is such a
> dynamic way to pass damaged area needed? omapfb is on the other end, you
> can just give one rectangle with it.


Hi Tomi,

Thanks, currently, I believe that hecubafb, metronomefb and
broadsheetfb would benefit although I've only implemented use of this
in broadsheetfb. I think there is possibility that sh and xen_pvfb can
benefit too. I think we can work on this together to make the API be
sufficiently generic.

Acknowledging that kzalloc is definitely not appropriate for all
drivers, I propose the following changes to the implementation.

a) allow userspace to determine optimal number of rectangles
FBIO_GETDAMAGE
which would allow the driver to report back (in the same fb_damage
structure) the optimal number of rectangles that it can support.

b) allow drivers to handle memory allocation as desired themselves
Instead of doing the copy_from_user and kzalloc in the higher level
fb_set_damage, we pass that user pointer directly to the driver. Thus,
it would be:
int (*fb_set_damage)(struct fb_info *info, struct fb_damage_user *damage);

and the driver can handle according to its needs.

>
> I have often been wondering about this, is it better to update one
> bigger area in one pass, or multiple smaller areas. I guess there's no
> real answer to it, though =).

I agree with you that it becomes dependent on the display controller
and display material that it is updating. In the case of broadsheetfb,
being able to isolate exactly which pixels need to be updated has
significant performance impact due to the fact that each pixel has to
be gpio-ed to the hardware, and the e-paper latency per waveform
update has to be expended as well, which is why rather than a global
bounding box, I had selected support of multiple bounding boxes.

Thanks,
jaya

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
