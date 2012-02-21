From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 21 Feb 2012 14:17:34 +0000
Subject: fb_set_suspend usage in suspend/resume
Message-Id: <A73F36158E33644199EB82C5EC81C7BC31769E56@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

I got to know from man pages that fb_set_suspend will signal about suspend and resume
of low level driver to FB core and client drivers. But why do majority of FB drivers
in drivers/video/ folder doesnot call fb_set_suspend in their suspend and resume implementation?

Thanks,
Prakash

