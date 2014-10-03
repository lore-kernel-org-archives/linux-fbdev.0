From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 03 Oct 2014 11:52:00 +0000
Subject: [PATCH v2 0/5] simplefb: Add clock support to simplefb
Message-Id: <1412337125-14388-1-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Tomi,

Here is v2 of the patch-set to add clocks support to simplefb.

Changes in v2:
-Added "simplefb: Add simplefb MAINTAINERS entry" patch

If you've followed the discussion sofar, then you know that not everyone
agrees 100% with this. The primary concern being that this will turn simplefb
into not-so-simplefb.

However no-one has been able to come up with a workable alternative solution.

We've asked input from Mike Turquette, the clk maintainer, and he agrees
that the solution in this patch-set is the right way to deal with clocks for
simplefb, and he has given his Reviewed-by for the dt-bindings patch.

As for the simplefb code becoming to complex for this, I noticed that
simplefb currently does not have an active maintainer. I've discussed this
with Stephen Warren <swarren@wwwdotorg.org>, the original author of simplefb,
and with his permisson I'm picking up maintainership of simplefb.

And as the new maintainer of simplefb I agree that the approach in this
patch-set is the best way forward, and I've added my Reviewed-by to Luc's
patches adding the clocks property support. I fully commit myself to
actively maintain simplefb for the foreseeable future.

I believe that having the acks of both the clk and simplefb maintainer
is more then good enough to get this set merged despite not everyone
agreeing 100% with it (note some people have expressed concerns, but no one
has actually nacked it).

Therefor I would like to ask you to merge this set for 3.19, or if there is
still time for 3.18.

Thanks & Regards,

Hans
