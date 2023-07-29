resource "aws_cloudwatch_log_metric_filter" "fetched_events_number" {
  name           = "FetchedEventsNumberFilter"
  pattern        = "[date, log_level, module, Fetched, num_events, events=events, for, user, user_id]"
  log_group_name = module.ecs.cloudwatch_log_group.name

  metric_transformation {
    name      = "FetchedEventsNumber"
    namespace = var.name
    value     = "$num_events"

    dimensions = {
      UserId = "$user_id"
    }
  }
}

resource "aws_cloudwatch_log_metric_filter" "fetched_attendees_number" {
  name           = "FetchedAttendeesNumberFilter"
  pattern        = "[date, log_level, module, Fetched, num_attendees, attendees=attendees, for, user, user_id]"
  log_group_name = module.ecs.cloudwatch_log_group.name

  metric_transformation {
    name      = "FetchedAttendeesNumber"
    namespace = var.name
    value     = "$num_attendees"

    dimensions = {
      UserId = "$user_id"
    }
  }
}

resource "aws_cloudwatch_log_metric_filter" "fetched_contacts_number" {
  name           = "FetchedContactsNumberFilter"
  pattern        = "[date, log_level, module, Fetched, num_contacts, contacts=contacts, for, user, user_id]"
  log_group_name = module.ecs.cloudwatch_log_group.name

  metric_transformation {
    name      = "FetchedContactsNumber"
    namespace = var.name
    value     = "$num_contacts"

    dimensions = {
      UserId = "$user_id"
    }
  }
}

resource "aws_cloudwatch_log_metric_filter" "bites_generation_result" {
  name           = "BitesGenerationResultFilter"
  pattern        = "[date, log_level, module, start=Bites, generation, result, bites_generated, for, user, user_id]"
  log_group_name = module.ecs.cloudwatch_log_group.name

  metric_transformation {
    name      = "BitesGenerationResult"
    namespace = var.name
    value     = "$bites_generated"

    dimensions = {
      UserId = "$user_id"
    }
  }
}

resource "aws_cloudwatch_log_metric_filter" "summary_generation_result" {
  name           = "SummaryGenerationResultFilter"
  pattern        = "[date, log_level, module, start=Summary, generation, result, result_value, for, user, user_id, and, streaming, is_streaming]"
  log_group_name = module.ecs.cloudwatch_log_group.name

  metric_transformation {
    name      = "SummaryGenerationResult"
    namespace = var.name
    value     = "$result_value"

    dimensions = {
      UserId        = "$user_id"
      WithStreaming = "$is_streaming"
    }
  }
}

resource "aws_cloudwatch_log_metric_filter" "openai_error_connection" {
  name           = "OpenAIConnectionErrorFilter"
  pattern        = "openai.error.APIConnectionError"
  log_group_name = module.ecs.cloudwatch_log_group.name

  metric_transformation {
    name      = "OpenAIConnectionErrorsCount"
    namespace = var.name
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "openai_error_request" {
  name           = "InvalidRequestToOpenAIFilter"
  pattern        = "openai.error.InvalidRequestError"
  log_group_name = module.ecs.cloudwatch_log_group.name

  metric_transformation {
    name      = "InvalidRequestToOpenAI"
    namespace = var.name
    value     = "1"
  }
}