From: Benson Leung <bleung@chromium.org>
Date: Wed, 13 May 2015 23:40:15 +0000
Subject: Re: [PATCH] backlight/lp855x: Don't clear level on suspend/blank
Message-Id: <CANLzEkugDXFVyYjVnXjP0vZsQttbdf-JAFTjkV3CU0rcsBDwcg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1431376325-25741-1-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1431376325-25741-1-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, May 11, 2015 at 1:32 PM, Sean Paul <seanpaul@chromium.org> wrote:
> Don't clear the backlight level when we're going into suspend or
> blanking. Instead, just temporarily set the level to 0 so we retain
> the value when we resume.
>
> Reported-by: Benson Leung <bleung@chromium.org>
> Tested-by: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>


-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
