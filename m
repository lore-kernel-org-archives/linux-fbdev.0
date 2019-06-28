From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 28 Jun 2019 12:53:09 +0000
Subject: Re: [PATCH 11/43] docs: console.txt: convert docs to ReST and rename to *.rst
Message-Id: <aab88ea1-0309-c18c-5ea6-3bdd72b45169@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
        <CGME20190628122050epcas1p28436f681c27ed04495778771e032c6de@epcas1p2.samsung.com>
        <e8cee712026b042eacf3e003a57578d963f24ad8.1561723980.git.mchehab+samsung@kernel.org>
In-Reply-To: <e8cee712026b042eacf3e003a57578d963f24ad8.1561723980.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org


On 6/28/19 2:20 PM, Mauro Carvalho Chehab wrote:
> Convert this small file to ReST in preparation for adding it to
> the driver-api book.
> 
> While this is not part of the driver-api book, mark it as
> :orphan:, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  .../console/{console.txt => console.rst}      | 63 ++++++++++---------
>  Documentation/fb/fbcon.rst                    |  4 +-
>  drivers/tty/Kconfig                           |  2 +-
>  3 files changed, 38 insertions(+), 31 deletions(-)
>  rename Documentation/console/{console.txt => console.rst} (80%)
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
