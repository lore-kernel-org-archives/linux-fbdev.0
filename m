From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 29 Jun 2011 21:05:00 +0000
Subject: Re: [uclinux-dist-devel] [PATCH] fbdev: bfin_adv7393fb: convert to seq_file
Message-Id: <BANLkTingNmwMf4eKYVh_beho309L_mPSSg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1309213715-31842-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1309213715-31842-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Mon, Jun 27, 2011 at 18:28, Mike Frysinger wrote:
> ->read_proc and ->write_proc interfaces are going away,
> switch to seq_file/->write().

actually, let's not merge this.  it has build errors:
drivers/video/bfin_adv7393fb.c:364: error: ‘adv7393_proc_write’
undeclared here (not in a function)

the code originally had "adv7393_write_proc", but the new code refers
to "adv7393fb_proc_write".  also, file_operations.write does not take
the same arguments as proc_dir_entry.write.  so this needs a little
more love than renaming the func.
-mike
