Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FC0C43334
	for <linux-fbdev@archiver.kernel.org>; Thu,  2 Jun 2022 20:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbiFBUCv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 2 Jun 2022 16:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbiFBUCn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 2 Jun 2022 16:02:43 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jun 2022 13:02:33 PDT
Received: from smtp687out9.mel.oss-core.net (smtp687out9.mel.oss-core.net [210.50.216.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A48A218E
        for <linux-fbdev@vger.kernel.org>; Thu,  2 Jun 2022 13:02:33 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2C0eQDRFZli/7NplnpaGQEBAQEBASsLBgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQIBAQEBAQEBAQEBARUJgUiBOgIBAQGkPocZG4IliWMLAQEBITAEAQGEe?=
 =?us-ascii?q?AEBhVEmOBMBAgQBAQEBAwIDAQEBAQEBAwEBBgEBAQEBAQYEgRyFL0aGVCAHA?=
 =?us-ascii?q?YFWAQ4BHoV1AQGsboEzDXSEWRSCEAQKgnOBOwIBAQEBAYlChV99gRCEEAGFf?=
 =?us-ascii?q?YNAgi4EkkaEIwQbOwMhFRg0EoEhRSwBCAYGBwoFMgYCDBgUBAITElMdAhIMC?=
 =?us-ascii?q?hwOVBkMDwMSAxEBBwILEggVLAgDAgMIAwIDLgIDGAkHCgMdCAoKEhIQFAIEB?=
 =?us-ascii?q?g0eCwgDGR8tCQIEDgNDCAsKAxEEAxMYCxYIEAQGAwkvDSgLAxQPAQYDBgIFB?=
 =?us-ascii?q?QEDIAMUAwUnBwMhBwsmDQ0EIx0DAwUmAwICGwcCAgMCBhcGAgJxCigNCAQIB?=
 =?us-ascii?q?AwQHSUTBQIHMQUELwIeBAUGEQkCFgIGBAUCBAQWAgISCAIIJxsHFjYZAQUOT?=
 =?us-ascii?q?wYLCSEcCSARBQYWAyNzBUgPKTU5BnwPrlKQQJ4zCoNOBSkHgQkHnkkxg2MBl?=
 =?us-ascii?q?xIRASeBV4tUlmioEoEZgX5wFYIIgRxQKJ0QgRACBgsBAQMJjwoBAQ?=
IronPort-Data: A9a23:3UMQTao+WbA4JKkpOFo4TQ36pEheBmKTZxIvgKrLsJaIsI4StFCzt
 garIBmBbviMYWD9ftBxYI2/oUlTsJTVm9YyT1do/C9gFH4WpePIVI+TRqvSF33LcpGbJK5EA
 2TyTvGacajYm1eF/k/F3oAMKRCQ7InQLlbGILes1htZGEk1EU/NtTo5w7Rj2tAw24Dja++wk
 YqaT/P3aQfNNwFcagr424rbwP+4lK2v0N+wlgVWicFj5DcypVFMZH4sDf3Zw0/Df2VhNrXSq
 9AvY12O1jixEx8FUrtJm1tgG6EAaua60QOm0hK6V0U+6/RPjnRa70o1CBYTQU1ukCzQsv968
 dVcl4boDlovB67zxs1IBnG0EwkmVUFH0IDmBz2d7uO942fvVCa14Z2CDmlvZ9deo7svRzgWq
 LpBd2FlghOr3opaxJq6TOdrrsEqKsX6eogYvxmMyBmJV657H8+fGM0m4/cChR0rxe9KJc+Zf
 usBaSM3Zhb+XRdmbwJ/5JUW2b3AamPEWzlZrk+F4KQ972XN5BJ+3aKrM9fPfNGOA8JPkS6lS
 nnupj6jR0hHbJnGkWfAqy39wPTTlGXkUpgVHbGy//hmxlue2ioaFXX6SGeGnBVwsWbmM/o3F
 qDe0nNGQXQanKBzcuTAYg==
IronPort-HdrOrdr: A9a23:CTTkx65bVU2bGpb4NgPXwKvXdLJyesId70hD6qkXc3Nom62j+/
 xG88576faZsl0ssQ8b+exoUZPoKU80k6Qa3WB7B92ftWfd1VeVEA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,272,1647262800"; 
   d="scan'208";a="82056743"
Received: from 122-150-105-179.sta.wbroadband.net.au (HELO WIN-J7GFDBAO51J) ([122.150.105.179])
  by smtp687.mel.oss-core.net with ESMTP; 03 Jun 2022 06:01:27 +1000
From:   "Martin Otamori" <info@mandy.com>
Subject: Acknowledge this message
To:     <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: <okkmart68@gmail.com>
Date:   Thu, 2 Jun 2022 13:01:24 -0700
Message-Id: <022320220601139471B9577A$D2DFC0A14F@mandy.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

I will give you more details as soon as you acknowledge this message.
Thank you.
Martin Otamori.

