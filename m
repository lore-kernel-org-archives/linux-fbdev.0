From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 22 Oct 2014 16:45:06 +0000
Subject: [PATCH v4 0/5] simplefb: add clock handling code
Message-Id: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Tomi,

Here is v4 of the patch-set to add clocks support to simplefb.

Changes in v2:
-Added "simplefb: Add simplefb MAINTAINERS entry" patch

Changes in v3:
-Improved description of simplefb binding

Changes in v4:
-Change clocks in simplefb from a linked-list to a (simpler) dynamically
 allocated array

v2 got some objections from some people because clocks are hardware description
and as such do not belong in a virtual device node as simplefb is. As explained
in the following thread the use of clocks in simplefb has nothing to do with   
clock topology (so hardware description), but is about which clocks of a
number of possible clocks where actually chosen by the firmware to bring
of the fb, as such this clearly is state description.

AFAIK at the end of the thread no one was disagreeing with this anymore
(I did not get any replies to my last mails explaining this).

Some of us also got together at the Plumbers conference in Dusseldorf to
discuss this, present were: David Herrmann, Maxime Ripard, Geert Uytterhoeven
and Hans de Goede (me), conclusions:
-We will add a clocks property to the simplefb devicetree bindings, so
 that u-boot setup framebuffers passed to the kernel (for early console
 support) can properly list the clocks used, and simplefb can claim them to
 avoid them getting turned off, thereby breaking the early console
-simplefb/simpledrm -> native-kms driver handoff will keep using the
 linear framebuffer address to identify which simplefb platform device to
 destroy during handoff, so that if their are multiple kms devices
 involved, the handover happens at the right moment and we don't loose
 console output anywhere (and we should be able to do a flickerfree
 handover)

Since we seem to have broad agreement on how to move forward with this, I
would like to ask you to please merge this patch-set for 3.19.

I know 3.19 is still somewhat ar away, but I would like to submit the u-boot
side of this to upstream ASAP, so can you please let me know if you plan to 
take this patch-set for 3.19 soon ?

Regards,

Hans
