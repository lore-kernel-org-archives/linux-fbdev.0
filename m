From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 02 Aug 2018 11:28:38 +0000
Subject: [PATCH fix for 4.19 0/3] fbcon: Fix VT switching being broken in combination with vgacon
Message-Id: <20180802112841.27679-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi Bartlomiej,

After backporting the deferred fbcon takeover patches to the 4.18
kernel for the upcoming Fedora 29 release, Fedora QA found a serious
bug caused by the fbcon takeover support.

When using classic (non EFI) boot on x86 and thus using vgacon, dummycon
is not used, so the deferred takeover never happens as that depends on
dummycon being the vt-console driver until the takeover happens.

This is fixed by the 2nd patch in this set, futher testing has shown that
that breaks the build when fb.o is a module, because of the conswitchp
symbol not being exported.  This made me realize that I never intended for
deferred fbcon takeover to be possible when fbdev+fbcon are being build as
a module (*), so instead of exporting yet more symbols, the first patch is
a preparation patch which only allows deferred fbcon takeover when builtin.

The third patch is a cleanup patch unexporting the dummycon_[un]register_output
symbols since those now no longer need to be exported.

At least patches 1 and 2 should be added to your tree for merging into 4.19,
patch 3 can go in in the 4.20 cycle if you prefer delaying it till then.

Regards,

Hans


*) which I should have realized when we hit the same issue with the
   dummycon_[un]register_output symbols
 
