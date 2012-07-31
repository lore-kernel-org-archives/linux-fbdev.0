From: Damien Cassou <damien.cassou@gmail.com>
Date: Tue, 31 Jul 2012 16:01:49 +0000
Subject: Re: [PATCH 4/5] drivers/video/da8xx-fb.c: use devm_ functions
Message-Id: <CA+y5ggjqq+u-kkQLApEAWs9vf29LuEXq_kA51T6HxsJcMM=HCQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343742860-16213-1-git-send-email-damien.cassou@lifl.fr>
 <1343742860-16213-3-git-send-email-damien.cassou@lifl.fr> <CAK9yfHxy4DGCwZjDCdc3A-a3oKoMGQruDMhfq0uR+2+7nfFHoA@mail.gmail.com>
In-Reply-To: <CAK9yfHxy4DGCwZjDCdc3A-a3oKoMGQruDMhfq0uR+2+7nfFHoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The whole patch is incorrect because of:

On Tue, Jul 31, 2012 at 5:47 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> -       ret = request_irq(par->irq, lcdc_irq_handler, 0,
>> -                       DRIVER_NAME, par);
>> +       ret = devm_request_irq(&device->dev, par->irq, lcdc_irq_handler, 0,
>> +                              DRIVER_NAME, par);

The following message explains why this is problematic:
http://marc.info/?l=kernel-janitors&m4374464625591&w=2

Please ignore this whole patch altogether.

Sorry about that.

-- 
Damien Cassou
http://damiencassou.seasidehosting.st

"Lambdas are relegated to relative obscurity until Java makes them
popular by not having them." James Iry
