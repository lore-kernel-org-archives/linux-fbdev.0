From: "Chris Verges" <chrisv@cyberswitching.com>
Date: Sat, 20 Mar 2010 19:25:25 +0000
Subject: kdrive vs. xorg rotation on AT91SAM9263 atmel_lcdfb
Message-Id: <68FBE0F3CE97264395875AC1C468F22C276323@mail03.cyberswitching.local>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi fellow fbdev users,

I'm seeking help with a migration from kdrive to xorg.  Under
kdrive-fbdev, I'm able to rotate the X11 output using xrandr in all four
orientations: normal, left, right, inverted.  However, under
xf86-video-fbdev, xrandr only reports that it does not support left,
right, or inverted rotations.  Dynamic rotation is critical for this
application, so I cannot use the "Rotate" option in xorg.conf.

The atmel_lcdfb driver that we're using in the kernel does not support
hardware rotation, so I believe that a software-based Shadow Buffer is
required.  (Please correct me if I'm wrong on this!)  I added in the
"ShadowFB" option to xorg.conf for the fbdev device, but xrandr still
only reports normal rotation possible.

I've hit a brick wall in my own research on this, so would appreciate
any help that the community can offer.  Any suggestions?

Thanks so much!
Chris
