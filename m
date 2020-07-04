From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 04 Jul 2020 14:35:43 +0000
Subject: [PATCH v1 0/1] dt-bindings: fix simple-framebuffer warning
Message-Id: <20200704143544.789345-1-sam@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Hans de Goede <hdegoede@redhat.com>, Sam Ravnborg <sam@ravnborg.org>

Trivial fix for a long standing warning.
At least not fixed in drm-msc-next for now.
Just in case it was not fixed by someone else (Rob?) already.

	Sam

Sam Ravnborg (1):
      dt-bindings: fix simple-framebuffer example

 .../bindings/display/simple-framebuffer.yaml       | 45 +++++++++++-----------
 1 file changed, 23 insertions(+), 22 deletions(-)
