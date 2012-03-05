From: Bernie Thompson <bernie@plugable.com>
Date: Mon, 05 Mar 2012 02:33:10 +0000
Subject: [GIT PULL] udlfb patches for fbdev-next
Message-Id: <CAO1w=s86ykpLJC8KkTbUn1qhvO52CJnzCKz5+rhS7mQtnwR4_w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

These are udlfb patches for fbdev-next (assume 3.4; compatible with 3.3)

Testing use of github to try to make patch submission easier.  1st
time. Be kind.
Not yet on git 1.7.9 for signed requests. Happy to send github pull requests.

All 5 patches are independent of each other.   Feedback welcome.

The following changes since commit 327e27681c27d3ed5ea470ec483904d1a318cb7f:

  video: s3c-fb: use devm_request_irq() (2012-02-24 00:50:07 +0000)

are available in the git repository at:
  git@github.com:bernieplug/linux-2.6.git fbdev-next

Ben Collins (2):
      udlfb: Make sure to get correct endian keys from vendor descriptor
      udlfb: Add module_param to allow forcing pixel_limit

Bernie Thompson (2):
      udlfb: add maintainer
      udlfb: fix hcd_buffer_free panic on unplug/replug

Martin Decky (1):
      udlfb: Improve debugging printouts with refresh rate

 MAINTAINERS           |    9 +++
 drivers/video/udlfb.c |  163 ++++++++++++++++++++++++++++--------------------
 include/video/udlfb.h |    1 +
 3 files changed, 105 insertions(+), 68 deletions(-)
