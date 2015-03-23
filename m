From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 23 Mar 2015 11:51:29 +0000
Subject: Re: [PATCH RESEND 2 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <20150323115129.GI10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426864935-29350-1-git-send-email-lstoakes@gmail.com>
 <20150323105323.GA10964@mwanda>
 <CAA5enKaPnRBT=8Tkx7rm6GQYXMvA=pwxmRYpnkRU8uHok8ypUg@mail.gmail.com>
In-Reply-To: <CAA5enKaPnRBT=8Tkx7rm6GQYXMvA=pwxmRYpnkRU8uHok8ypUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Oh hm...  This is an actual RESEND patch.

RESEND is a flag to show a mess up in the system.  I like to take a look
at those to see what went wrong.  The process failure was that you
messed up the threading earlier.  Take a look at the --in-reply-to flag.

regards,
dan carpenter

