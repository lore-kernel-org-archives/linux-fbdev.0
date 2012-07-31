From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 31 Jul 2012 13:57:57 +0000
Subject: Re: [PATCH 2/5] drivers/video/bfin-t350mcqb-fb.c: use devm_ functions
Message-Id: <CAMjpGUdo0SavFWR_tk50_6nZMsJmxYO5BxH9Fp=UTw5sW-0+Rw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343742860-16213-1-git-send-email-damien.cassou@lifl.fr> <1343742860-16213-5-git-send-email-damien.cassou@lifl.fr>
In-Reply-To: <1343742860-16213-5-git-send-email-damien.cassou@lifl.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Damien Cassou <damien.cassou@lifl.fr>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 31, 2012 at 9:54 AM, Damien Cassou <damien.cassou@lifl.fr> wrote:
> The various devm_ functions allocate memory that is released when a driver
> detaches.  This patch uses these functions for data that is allocated in
> the probe function of a platform device and is only freed in the remove
> function.

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
