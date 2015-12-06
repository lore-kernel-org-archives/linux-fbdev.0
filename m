From: Ran Shalit <ranshalit@gmail.com>
Date: Sun, 06 Dec 2015 07:35:26 +0000
Subject: fbdev - wipe screen (dd) with ioctl ?
Message-Id: <CAJ2oMhLh5EY=O3PCrgeOde2qFYJkVVC5H4dK5kwLqYWVUfmKqw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org

Hello,

I use the following to wipe a screen:
dd if=/dev/zero of=/dev/fb0 code

Is there a way to do the same thing in code (using ioctl I suppose) ?

Regards,
Ran
