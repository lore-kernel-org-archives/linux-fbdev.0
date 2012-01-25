From: hubert-b@gmx.de
Date: Wed, 25 Jan 2012 13:40:14 +0000
Subject: Length of pseudo_palette
Message-Id: <4F20063E.3050807@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi frame buffer developers,

I'm wondering about the size of the pseudo_palette: In [1] it is stated 
that it always has 17 entries - 16 for the console colors and the last 
one for the cursor. But googling around I found this posts [2] [3] from 
January 2003 that mention that this is not true anymore. So the question 
is are 16 entries enough for fbcon? Or did I miss something else here? 
Because I saw a lot of frame buffer drivers allocating 256 and I don't 
know what this might be good for.

Thanks in advance!

[1] http://www.linux-fbdev.org/HOWTO/4.html
[2] http://permalink.gmane.org/gmane.linux.fbdev.devel/946
[3] http://permalink.gmane.org/gmane.linux.fbdev.devel/978
