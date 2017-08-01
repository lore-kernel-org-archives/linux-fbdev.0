From: Tommy Giesler <mail@tomgie.de>
Date: Tue, 01 Aug 2017 06:44:42 +0000
Subject: [sm750fb] Sunix 2D VGA controller causes kernel panic and crash on boot
Message-Id: <b04b0b06f2e7dbb0f9d3db29a86e0a1a@tomgie.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

I have recently submitted a bug report to the Ubuntu bugtracker, since 
one of our test installations of Ubuntu 17.10 kept failing to boot and I 
was pointed to this mailing list.

The system is using a Sunix 2D graphics controller, which uses a Silicon 
Motion SM750, for video output.

Starting with Kernel 4.11 the system was no longer able to boot when 
using the sm750fb module.

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1707641

After blacklisting the module the system was working fine again. There 
were no known issues prior to Kernel 4.11.

Since all the log files were already attached in the Ubuntu bugtracker, 
I hope it is fine, that I don't attach them here again.

Please let me know, if you need any further information.
