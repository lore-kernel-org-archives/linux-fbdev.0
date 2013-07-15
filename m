From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 15 Jul 2013 15:26:59 +0000
Subject: [PATCH 0/3] Few ignored framebuffer fixes/additions
Message-Id: <1373902022-20439-1-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Andrew, 

Sorry to bother you again with the framebuffer stuff but the new
maintainer doesn't appear to be responsive either.k

This is a collection of patches that have been silently ignored,
despite being pinged numerous times:
  - Patch 1 has been sent for the first time on June 7 [1], resent on
    June 18 [2], plus two pings on July, 3rd [3] and July, 12th [4]. With
    no comments whatsoever.
  - Patch 2 has been sent on June, 21st [5]. Jean Christophe commented
    on it on June, 24th [6], but every attempts at getting clear
    explanations on what was expected have been ignored ever since
    (June 25th [7], July 12th [8])
  - Patch 3 was sent on June 21st along with Patch 2 [9]. There was
    comments on it and a second version was sent on June 24th
    [10]. Without any comments so far.

Could you take a look at those patches? We already missed 3.11, and
I'd really like not to miss another merge window because of the fbdev
curse.

Thanks,
Maxime

[1]: https://lkml.org/lkml/2013/6/7/116
[2]: https://lkml.org/lkml/2013/6/18/130
[3]: https://lkml.org/lkml/2013/7/3/105
[4]: https://lkml.org/lkml/2013/7/12/177
[5]: https://lkml.org/lkml/2013/6/21/405
[6]: https://lkml.org/lkml/2013/6/24/313
[7]: https://lkml.org/lkml/2013/6/25/274
[8]: https://lkml.org/lkml/2013/7/12/103
[9]: https://lkml.org/lkml/2013/6/21/407
[10]: https://lkml.org/lkml/2013/6/24/302

Alexandre Belloni (1):
  fb: backlight: HX8357: Add HX8369 support

Hector Palacios (1):
  video: mxsfb: fix color settings for 18bit data bus and 32bpp

Maxime Ripard (1):
  video: hx8357: Make IM pins optional

 drivers/video/backlight/hx8357.c | 255 +++++++++++++++++++++++++++++++++------
 drivers/video/mxsfb.c            |  26 ----
 2 files changed, 218 insertions(+), 63 deletions(-)

-- 
1.8.3.2

