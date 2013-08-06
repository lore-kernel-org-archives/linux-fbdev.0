From: Cliff Brake <cliff.brake@gmail.com>
Date: Tue, 06 Aug 2013 16:15:12 +0000
Subject: kernel mode splash screen
Message-Id: <CAOd_LFwxndi-rWgH2SncyO1K3QoS_wRuXf=cJGPVWx66kMy_SQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello,

We are working on an embedded system where we need immediate feedback
on the screen in response to power button events, etc.  We also need
to be able to display the splash screen whenever kernel is running.
User space splash screens get killed too early on shutdown, etc.

Does anyone know of a kernel mode splash screen that will:

1) display an image
2) display status messages
3) display progress bar (nice to have, but not required)
4) can be accessed from kernel and user space
5) when enabled, will disable writes from user space
6) FB based

Thanks,
Cliff

-- 
========http://bec-systems.com
